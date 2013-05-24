Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ufrnh-0007DN-8G
 for kexec@lists.infradead.org; Fri, 24 May 2013 13:12:53 +0000
Date: Fri, 24 May 2013 09:12:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v8 3/9] vmcore: treat memory chunks referenced by PT_LOAD
 program header entries in page-size boundary in vmcore_list
Message-ID: <20130524131217.GA18218@redhat.com>
References: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
 <20130523052513.13864.85440.stgit@localhost6.localdomain6>
 <20130523144928.0328bb3ad7ccc1ff2da9558d@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130523144928.0328bb3ad7ccc1ff2da9558d@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

On Thu, May 23, 2013 at 02:49:28PM -0700, Andrew Morton wrote:
> On Thu, 23 May 2013 14:25:13 +0900 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
> > Treat memory chunks referenced by PT_LOAD program header entries in
> > page-size boundary in vmcore_list. Formally, for each range [start,
> > end], we set up the corresponding vmcore object in vmcore_list to
> > [rounddown(start, PAGE_SIZE), roundup(end, PAGE_SIZE)].
> > 
> > This change affects layout of /proc/vmcore.
> 
> Well, changing a userspace interface is generally unacceptable because
> it can break existing userspace code.
> 
> If you think the risk is acceptable then please do explain why.  In
> great detail!

I think it should not be a problem as /proc/vmcore is useful only when
one parses the elf headers and then accesses the contents of file based
on the header information. This patch just introduces additional areas
in /proc/vmcore file and ELF headers still point to right contents. So
any tool parsing ELF headers and then accessing file contents based on
that info should still be fine.

AFAIK, no user space tool should be broken there.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
