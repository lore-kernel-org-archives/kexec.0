Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UZjkp-0006QW-5U
 for kexec@lists.infradead.org; Tue, 07 May 2013 15:24:35 +0000
Date: Tue, 7 May 2013 11:24:01 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 7/8] vmcore: treat memory chunks referenced by PT_LOAD
 program header entries in page-size boundary in vmcore_list
Message-ID: <20130507152401.GB12965@redhat.com>
References: <20130413002000.18245.21513.stgit@localhost6.localdomain6>
 <20130413002145.18245.73180.stgit@localhost6.localdomain6>
 <20130429195154.GR8204@redhat.com>
 <5188AF5C.2070807@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5188AF5C.2070807@jp.fujitsu.com>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com, jingbai.ma@hp.com

On Tue, May 07, 2013 at 04:38:04PM +0900, HATAYAMA Daisuke wrote:

[..]
> >>  		/* Update the program header offset. */
> >>-		phdr_ptr->p_offset = vmcore_off;
> >>-		vmcore_off = vmcore_off + phdr_ptr->p_memsz;
> >>+		phdr_ptr->p_offset = vmcore_off + (paddr - start);
> >
> >What's paddr-start. Why following is not sufficient.
> >
> >phdr_ptr->p_offset = vmcore_off
> >
> 
> (paddr - start) is offset of the memory program header refers to,
> from which kernel memory starts. Pictrically:
> 
>   vmcore_off                   +----------------------+
>                                |  extra memory        |
>                                |  (non kernel memory) |
> phdr->p_offset =               +----------------------+
>   vmcore_off + (paddr - start) |                      |\
>                                |  kernel memory       | phdr->p_memsz
>                                |                      |/
>                                +----------------------+
>                                |  extra memory        |
>                                |  (non kernel memory) |
>   vmcore_off + size            +----------------------+

Ok, got it. So PT_LOAD header refers to only part of memory and we
align start and end to PAGE_SIZE and then add that full chunk to
vmcore list. We update the phdr->offset to point to PT_LOAD
mapping. vc_list area can contain the page aligned extra memory at the
beginning and end and that can be read from old memory if user wishes
to.

So this is not an issue.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
