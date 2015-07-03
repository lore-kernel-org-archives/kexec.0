Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZAsew-0005IQ-CP
 for kexec@lists.infradead.org; Fri, 03 Jul 2015 04:33:06 +0000
Date: Fri, 3 Jul 2015 10:02:41 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] makedumpfile: Support ARM64
Message-ID: <20150703043241.GC21990@dhcppc13.redhat.com>
References: <d76572d93d25b0196cb2b32c88fd15dc4eb78682.1431714565.git.panand@redhat.com>
 <CAOZdJXWjZmL_K=FmvBU=U3VSDY9R4AucFU16v8CAgQCEe8HYDg@mail.gmail.com>
 <20150624033241.GA22348@localhost.localdomain>
 <558A25A3.60504@codeaurora.org>
 <20150627082256.GE21646@localhost.localdomain>
 <ddc87d025100347122b078b5104ec88c.squirrel@www.codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ddc87d025100347122b078b5104ec88c.squirrel@www.codeaurora.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Azriel Samson <asamson@codeaurora.org>
Cc: Timur Tabi <timur@codeaurora.org>, virajm@codeaurora.org, kexec@lists.infradead.org, ats-kumagai@wm.jp.nec.com

Hi Azriel,

On 01/07/2015:06:42:46 PM, Azriel Samson wrote:
> Hi Pratyush,
> =

> I am working with Timur and we are testing your version of makedumpfile.

Thanks for testing.

> The tool is unable to get the kernel version and quits from check_release=
().

Couple of questions:

1. Can you please let me know VA_BITS configured in your case?

2. Do you expect any regions other than vmalloc, vmemmap or modules,
which are not directly mapped and their physical address need to be
found from swapper_pg_dir?

In my vmcore, I did not had any address where
is_vtop_from_page_table_arm64 would be true. So, vtop_arm64 function
has been only cross checked logically. So,
a) Please put a print in vtop_arm64 and check if control goes there?
b) if yes, then please print vaddr and paddr at the end of vtop_arm64
and see if that is correct. If not we need to debug vtop_arm64.

~Pratyush

> =

> I tried to debug the vmcore file with gdb but the file looks corrupt.
> =

> Let me know if you have any ideas on what could be wrong?
> =

> > Hi Timur,
> >
> > On 23/06/2015:10:36:03 PM, Timur Tabi wrote:
> >> Pratyush Anand wrote:
> >> >I can try to find out some time in weekend to refactor arm64 code
> >> >and then add 3 level, 4K support. May be I will need a Tested-by.
> >>
> >> We'd be more than happy to test any code from you promptly.  We're eag=
er
> >> to
> >> get this to work.
> >
> > I have done the changes, hopefully it should work, but have not
> > tested. Let me know, if it works will send them as formal patches
> > to upstream.
> >
> > https://github.com/pratyushanand/makedumpfile.git : arm64_support
> > (9b95423bcea0)
> >
> > ~Pratyush
> >
> =

> -- =

> Thanks,
> Azriel Samson
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum=
,=A0
> a Linux Foundation Collaborative Project

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
