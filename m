Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vj0Oy-0003hi-5O
 for kexec@lists.infradead.org; Wed, 20 Nov 2013 05:32:38 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: /proc/vmcore mmap() failure issue
Date: Wed, 20 Nov 2013 05:27:59 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971C3845@BPXM01GP.gisp.nec.co.jp>
References: <20131113204130.GD7613@redhat.com>
 <5284A689.70903@jp.fujitsu.com> <20131114151359.GA3913@redhat.com>
 <5285EC60.1060906@jp.fujitsu.com> <20131115142617.GC6637@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971BF592@BPXM01GP.gisp.nec.co.jp>
 <528B3585.5080606@jp.fujitsu.com>
In-Reply-To: <528B3585.5080606@jp.fujitsu.com>
Content-Language: ja-JP
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "chaowang@redhat.com" <chaowang@redhat.com>

On 2013/11/19 18:56:21, kexec <kexec-bounces@lists.infradead.org> wrote:
> (2013/11/18 9:51), Atsushi Kumagai wrote:
> > (2013/11/15 23:26), Vivek Goyal wrote:
> >> On Fri, Nov 15, 2013 at 06:41:52PM +0900, HATAYAMA Daisuke wrote:
> >>
> >> [..]
> >>>> Given the fact that hpa does not like fixing it in kernel. We are 
> >>>> left with option of fixing it in following places.
> >>>>
> >>>> - Drop partial pages in kexec-tools
> >>>> - Drop partial pages in makeudmpfile.
> >>>> - Read partial pages using read() interface in makedumpfile
> >>>> - Modify /proc/vmcore to copy partial pages in second kernel's memory.
> >>>>
> >>>> It is not clear to me that partial pages are really useful.  So I 
> >>>> want to avoid modifying /proc/vmcore to deal with partial pages and 
> >>>> increase complexity.
> >>>>
> >>>> So fixing makedumpfile (either option2 or option 3) seems least 
> >>>> risky to me. In fact I would say let us keep it simple and truncate 
> >>>> partial pages in makedumpfile to keep it simple. And look at option 
> >>>> 3 once we have a strong use case for partial pages.
> >>>>
> >>>> What do you think?
> >>>>
> >>>
> >>> As you say, it's not clear that partial pages are really useful, but 
> >>> on the other hand, it seems to me not clear that they are really useless.
> >>> I think we should get them as long as we have access to them.
> >>>
> >>> It seems best to me the option 3). Switching between read and mmap 
> >>> would be not so complex and also it's by far flexible in 
> >>> makedumpfile than in kernel.
> >>
> >> Ok, I am fine with option 3. It is more complicated option but safe 
> >> option.
> > 
> > It sounds reasonable also to me.
> > 
> >> Is there any chance that you could look into fixing this. I have no 
> >> experience writing code for makedumpfile.
> > 
> > I'll send a patch to fix this soon.
> > 
> 
> Thanks.
> 
> BTW, now the following patch has been applied on top of makedumpfile in kexec-tools package on fedora in order to avoid the issue.
> 
> https://lists.fedoraproject.org/pipermail/kexec/2013-November/000254.html
> 
> I remember prototype version of mmap patch implemented a kind of --no-mmap option and we could use it to disable mmap() use and use read() instead, I think which is useful when we face this kind of issue.

How about this fail back structure instead of such an extra option ?

Thanks
Atsushi Kumagai

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Wed, 20 Nov 2013 14:10:19 +0900
Subject: [PATCH] Fall back to read() when mmap() fails.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ca03440..f583602 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -324,7 +324,15 @@ read_from_vmcore(off_t offset, void *bufptr, unsigned long size)
 		if (!read_with_mmap(offset, bufptr, size)) {
 			ERRMSG("Can't read the dump memory(%s) with mmap().\n",
 			       info->name_memory);
-			return FALSE;
+
+			ERRMSG("This kernel might have some problems about mmap().\n");
+			ERRMSG("read() will be used instead of mmap() from now.\n");
+
+			/*
+			 * Fall back to read().
+			 */
+			info->flag_usemmap = FALSE;
+			read_from_vmcore(offset, bufptr, size);
 		}
 	} else {
 		if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
-- 
1.8.0.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
