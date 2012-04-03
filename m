Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from s2securityips03.s.subnet.rcn.com ([209.6.33.98]
 helo=s2exchange2.hq.s2sys.com)
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SF2HO-0001x1-Fa
 for kexec@lists.infradead.org; Tue, 03 Apr 2012 11:52:08 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Fwd: RE: Fwd: Re: makedumpfile security key enhancement using SIAL
Date: Tue, 3 Apr 2012 07:52:01 -0400
Message-ID: <C14DE2E60140984C9CEB63D47F21D9D403D07CE3@s2exchange2.hq.s2sys.com>
In-Reply-To: <4F7AE219.2000309@linux.vnet.ibm.com>
References: <4F7343CB.2070108@linux.vnet.ibm.com>
 <4F7AE219.2000309@linux.vnet.ibm.com>
From: "Luc Chouinard" <LChouinard@s2sys.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, David Anderson <anderson@redhat.com>

My hope  is to have something available 2 weeks from now. No promises - I have a few  critical deliveries to take care here @ s2 first.
First step is to finish off some significant  fixes and enhancements to the compiler (like the support for typeof() and typed symbols) which will make it possible to include and use what I now found to be pervasive macros like hlist_for_each_entry_rcu(), offsetof(), container_of() as-is.

  -Luc

> -----Original Message-----
> From: Aravinda Prasad [mailto:aravinda@linux.vnet.ibm.com]
> Sent: Tuesday, April 03, 2012 7:42 AM
> To: Luc Chouinard
> Cc: kexec@lists.infradead.org; Ananth N Mavinakayanahalli; Mahesh J
> Salgaonkar; Masaki Tachibana; Atsushi Kumagai; David Anderson
> Subject: Re: Fwd: RE: Fwd: Re: makedumpfile security key enhancement using
> SIAL
> 
> Hi Luc,
> 
> Could you please let us know by when you are planning to create the project and
> associated git for SIAL? Right now we are extracting libsial from the crash tar
> ball and using it.
> 
> Regards,
> Aravinda
> 
> On Wednesday 28 March 2012 10:30 PM, Aravinda Prasad wrote:
> > Thanks Luc. We will let you know if in case we need any info/help.
> >
> > I am also forwarding this mail to kexec mailing list.
> >
> > Regards,
> > Aravinda
> >
> >
> > -------- Original Message --------
> > Subject: RE: Fwd: Re: makedumpfile security key enhancement using SIAL
> > Date: Wed, 28 Mar 2012 07:07:49 -0400
> > From: Luc Chouinard <LChouinard@s2sys.com>
> > To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >
> > Libsial is meant to be a pluggable entity and as such should not
> > require other pieces to be there ( crash or gdb).
> > I want to create project and associated git for the library soon. For
> > now you can extract libsial from the crash tar ball and manage any
> > modifications using a simple patch mechanism. When the git is
> > available, we can merge any fixes or enhancements you created for
> > support of makedumpfile.
> >
> > Makedumpfile and crash would then feed off of specific
> > branches/versions of the git repository.
> > If you have any suggestions or want to help in setting up a public git
> > / project page for sial, please let me know.
> >
> >
> > -Luc
> >
> >> -----Original Message-----
> >> From: Aravinda Prasad [mailto:aravinda@linux.vnet.ibm.com]
> >> Sent: Wednesday, March 28, 2012 1:31 AM
> >> To: Luc Chouinard
> >> Subject: Fwd: Fwd: Re: makedumpfile security key enhancement using
> >> SIAL
> >>
> >> Forwarding to your s2sys email ID. Details in mail forward.
> >>
> >> Regards,
> >> Aravinda
> >>
> >>
> >> -------- Original Message --------
> >> Subject: Fwd: Re: makedumpfile security key enhancement using SIAL
> >> Date: Tue, 20 Mar 2012 17:28:21 +0530
> >> From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> To: Luc Chouinard <lucchouina@yahoo.com>
> >> CC: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Masaki
> >> Tachibana <tachibana@mxm.nes.nec.co.jp>, Mahesh J Salgaonkar
> >> <mahesh@linux.vnet.ibm.com>, Ananth N Mavinakayanahalli
> >> <ananth@in.ibm.com>, Dave Anderson <anderson@redhat.com>
> >>
> >> Hi Luc,
> >>
> >> We are looking for utilising SIAL as a language construct for the
> >> makedumpfile kernel data filtering from vmcore feature. The details
> >> of which are in the mail forward.
> >>
> >> The proposed enhancement will require libsial.a and as SIAL is not
> >> currently built/shipped, we are looking for possibilities on how
> >> libsial.a can be made available to makedumpfile. Please let us know
> >> your opinion on the same.
> >>
> >> Regards,
> >> Aravinda
> >>
> >>
> >> -------- Original Message --------
> >> Subject: Re: makedumpfile security key enhancement using SIAL
> >> Date: Tue, 13 Mar 2012 10:27:43 -0400 (EDT)
> >> From: Dave Anderson <anderson@redhat.com>
> >> To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> CC: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Masaki
> >> Tachibana <tachibana@mxm.nes.nec.co.jp>, Ananth N Mavinakayanahalli
> >> <ananth@in.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
> >>
> >>
> >>
> >> ----- Original Message -----
> >> > Hi Dave,
> >> >
> >> > Last year, we worked on the makedumpfile security key filtering
> >> > where we added support to filter out kernel data from vmcore. This
> >> > year, we are working on enhancing the framework to provide more
> >> > flexibility for the customers to specify rules to traverse and
> >> > filter out kernel data
> >> > - for which we are planning to use SIAL.
> >> >
> >> > We are looking into using SIAL as language construct to specify
> >> > rules/commands to erase data in the image file. The makedumpfile
> >> > would interpret the rules provided in SIAL macro using SIAL library
> >> > (which could be dynamically loaded) and erase out suitable data in the
> vmcore.
> >> > We are planning to reuse SIAL as it provides a C language like
> >> > construct, which is flexible and powerful enough to specify rules
> >> > to erase data in vmcore.
> >> >
> >> > As SIAL is not built and shipped along with crash, we are looking
> >> > for possibilities on how SIAL can be leveraged by makedumpfile and
> >> > would like to know your opinion.
> >>
> >> Sorry but I cannot give you any help with SIAL. Luc Chouinard is the
> >> maintainer of the SIAL extension module adaptation for the crash
> >> utility, and he can answer your questions w/respect to adapting it
> >> for makedumpfile.
> >> And ultimately, that's a question for the makedumpfile maintainers.
> >>
> >> Dave
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
