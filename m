Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f6U63-0004K0-Ok
 for kexec@lists.infradead.org; Thu, 12 Apr 2018 04:44:33 +0000
From: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Subject: RE: [PATCH 0/4] Makedumpfile: Add 5-level paging support
Date: Thu, 12 Apr 2018 04:42:19 +0000
Message-ID: <61D4E5D821F1674CB87C99F080A210BE0118CC47@BPXM01GP.gisp.nec.co.jp>
References: <20180302054841.22195-1-bhe@redhat.com>
 <20180412024521.GO19345@localhost.localdomain>
In-Reply-To: <20180412024521.GO19345@localhost.localdomain>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: "douly.fnst@cn.fujitsu.com" <douly.fnst@cn.fujitsu.com>, "indou.takao@jp.fujitsu.com" <indou.takao@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Keiichi Nakamura <kei-nakamura@vt.jp.nec.com>

Hi Baoquan,

Sorry for the late reply.
I'll merge the patches into V1.6.4.
However, I need time to acknowledge formally.
Please wait some weeks.

Thanks
Tachibana

> -----Original Message-----
> From: Baoquan He [mailto:bhe@redhat.com]
> Sent: Thursday, April 12, 2018 11:45 AM
> To: Tachibana Masaki() <mas-tachibana@vf.jp.nec.com>; Hayashi Masahiko() <mas-hayashi@tg.jp.nec.com>;
> Nakayama Takuya() <tak-nakayama@tg.jp.nec.com>
> Cc: douly.fnst@cn.fujitsu.com; indou.takao@jp.fujitsu.com; kexec@lists.infradead.org
> Subject: Re: [PATCH 0/4] Makedumpfile: Add 5-level paging support
> 
> Hi Tachibana, Nakayama,
> 
> Ping!
> 
> Now 5-level suport on x86 64 has been merged into 4.16, do we have plan
> to merge this patchset? Or defer to a certain phase?
> 
> Thanks
> Baoquan
> 
> On 03/02/18 at 01:48pm, Baoquan He wrote:
> > Kernel has 5-level paging support and now can support boot-time
> > switching between 4/5-level paging mode. This patchset is used to add
> > 5-level paging support in makedumpfile.
> >
> > A kernel fix is posted to export 'pgtable_l5_enabled' to tell if
> > the corrupted kernel is in 5-level paging mode.
> > https://patchwork.kernel.org/patch/10253399/
> >
> > Patch 0001 and 0004 were made by Dou Liyang. While it doesn't work on
> > the latest 5-level code. So add patch 0002 to introduce 'pgtable_l5_enabled'.
> > Change and take out the function check_5level_paging() from dou's old
> > patch and add it into patch 0003. Except of these, don't touch other
> > part of dou's patches.
> >
> > Thanks, dou, for the effort!
> >
> > Baoquan He (2):
> >   Makedumpfile: Add pgtable_l5_enabled to number_table
> >   Makedumpfile: Add a new function check_5level_paging()
> >
> > Dou Liyang (2):
> >   arch/x86_64: Cleanup the address translation of the 4-level page
> >     tables
> >   arch/x86_64: Add 5-level paging support
> >
> >  arch/x86_64.c  | 130 +++++++++++++++++++++++++++++++++++++++++----------------
> >  makedumpfile.c |   3 ++
> >  makedumpfile.h |  39 +++++++++++------
> >  3 files changed, 123 insertions(+), 49 deletions(-)
> >
> > --
> > 2.13.6
> >



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
