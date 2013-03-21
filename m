Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIgE3-0001bw-0i
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 14:12:17 +0000
Date: Thu, 21 Mar 2013 10:12:02 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 01/21] vmcore: reference e_phoff member explicitly to
 get position of program header table
Message-ID: <20130321141202.GF3934@redhat.com>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040053.15064.93652.stgit@localhost6.localdomain6>
 <87ppyvnjyn.fsf@xmission.com>
 <20130321.115041.225288996.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130321.115041.225288996.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com

On Thu, Mar 21, 2013 at 11:50:41AM +0900, HATAYAMA Daisuke wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
> Subject: Re: [PATCH v3 01/21] vmcore: reference e_phoff member explicitly to get position of program header table
> Date: Tue, 19 Mar 2013 14:44:16 -0700
> 
> > HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
> > 
> >> Currently, the code assumes that position of program header table is
> >> next to ELF header. But future change can break the assumption on
> >> kexec-tools and the 1st kernel. To avoid worst case, reference e_phoff
> >> member explicitly to get position of program header table in
> >> file-offset.
> > 
> > In principle this looks good.  However when I read this it looks like
> > you are going a little too far.
> > 
> > You are changing not only the reading of the supplied headers, but
> > you are changing the generation of the new new headers that describe
> > the data provided by /proc/vmcore.
> > 
> > I get lost in following this after you mangle merge_note_headers.
> > 
> > In principle removing silly assumptions seems reasonable, but I think
> > it is completely orthogonal to the task of maping vmcore mmapable.
> > 
> > I think it is fine to claim that the assumptions made here in vmcore are
> > part of the kexec on panic ABI at this point, which would generally make
> > this change unnecessary.
> 
> This was suggested by Vivek. He prefers generic one.
> 
> Vivek, do you agree to this? Or is it better to re-post this and other
> clean-up patches as another one separately to this patch set?

Given the fact that current code has been working, I am fine to just
re-post and take care of mmap() related issues. And we can take care
of cleaning up of some assumptions about PT_NOTE headers later. Trying
to club large cleanup with mmap() patches is making it hard to review.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
