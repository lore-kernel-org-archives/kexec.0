Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hTnkK-0000o8-NU
 for kexec@lists.infradead.org; Thu, 23 May 2019 13:27:05 +0000
Date: Thu, 23 May 2019 21:26:50 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 1/4] x86: Update boot parameters defination
Message-ID: <20190523132650.GA12251@dhcp-128-65.nay.redhat.com>
References: <20190514050959.21093-1-kasong@redhat.com>
 <20190514050959.21093-2-kasong@redhat.com>
 <20190523030144.GA8174@dhcp-128-65.nay.redhat.com>
 <CACPcB9c=TCn2Xy8sPwOjjFBTGcMe0_W5uLm-q7c9YDF2dYJivg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACPcB9c=TCn2Xy8sPwOjjFBTGcMe0_W5uLm-q7c9YDF2dYJivg@mail.gmail.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>

On 05/23/19 at 07:12pm, Kairui Song wrote:
> On Thu, May 23, 2019 at 11:01 AM Dave Young <dyoung@redhat.com> wrote:
> >
> > Hi Kairui
> > On 05/14/19 at 01:09pm, Kairui Song wrote:
> > > Since kernel commit e6e094e053af75 ("x86/acpi, x86/boot: Take RSDP address
> > > from boot params if available"), kernel accept a acpi_rsdp_addr param in
> > > boot_params. Sync the x86_linux_param_header to support this param.
> > >
> > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > > ---
> > >  include/x86/x86-linux.h | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
> > > index 352ea02..a5d8df8 100644
> > > --- a/include/x86/x86-linux.h
> > > +++ b/include/x86/x86-linux.h
> > > @@ -45,8 +45,7 @@ struct apm_bios_info {
> > >       uint16_t cseg_len;      /* 0x4e */
> > >       uint16_t cseg_16_len;   /* 0x50 */
> > >       uint16_t dseg_len;      /* 0x52 */
> > > -     uint8_t  reserved[44];  /* 0x54 */
> > > -};
> > > +} __attribute__((packed));
> >
> > It should be good to keep same as the kernel header without packed
> > attribute.
> >
> > is it possible to sync the latest mainline uapi bootparam header file,
> > maybe after this series get solved?
> >
> 
Hi Kairui,

> Hi Dave,
> 
> I can remove the packed attr then, just ensure it won't break
> anything, a bit paranoid maybe...
> 
> About sync the whole structure, the problem is kexec tools' header
> structure is different so that will change a lot. Maybe could be
> discussed seperately.

Yes, agreed, it is not necessary to do in this series.

> 
> -- 
> Best Regards,
> Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
