Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VfypF-0002Rc-7g
 for kexec@lists.infradead.org; Mon, 11 Nov 2013 21:15:13 +0000
Date: Mon, 11 Nov 2013 16:14:51 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kexec query about what makes sure control pages/page tables are
 not overwritten
Message-ID: <20131111211451.GF11547@redhat.com>
References: <20131111205341.GE11547@redhat.com>
 <15b29390-b535-4157-b7f2-8b1e03c919c1@email.android.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15b29390-b535-4157-b7f2-8b1e03c919c1@email.android.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Mon, Nov 11, 2013 at 12:57:12PM -0800, H. Peter Anvin wrote:
> It is pretty simple: the kernel exports how much text+data+bss+brk it needs, and the kernel cannot use memory outside that region until it is ready to control the address space itself.

Ok. So looks like that field is.

0260/4  2.10+   init_size       Linear memory required during initialization

This helps. Thanks.

Vivek

>
 
> Vivek Goyal <vgoyal@redhat.com> wrote:
> >Hi,
> >
> >I am staring at control page allocation logic in case of kdump and
> >wondering what makes sure that these pages are not overwritten by 
> >next kernel.
> >
> >I see that for 64bit entry, control pages have the page tables needed
> >for second kernel. In case of crash these pages from from crash kernel
> >reserved region. Page allocator is very simple and that is start from
> >lowest crash reserved range and move higher and allocate first
> >available
> >page which is not allocated to segments. What makes sure that these
> >pages
> >are not overwritten by second kernel.
> >
> >I guess it becomes a general bootloader question. How do we make sure
> >bootloader prepared page tables/gdt will not be overwritten by kernel
> >(till kernel sets up its own page tables and gdt) and how should we do
> >the
> >allocation and placement.
> >
> >Thanks
> >Vivek
> 
> -- 
> Sent from my mobile phone.  Please pardon brevity and lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
