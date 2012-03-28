Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e38.co.us.ibm.com ([32.97.110.159])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SCwG1-0001gx-DO
 for kexec@lists.infradead.org; Wed, 28 Mar 2012 17:02:02 +0000
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 28 Mar 2012 11:01:52 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1410119D8050
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 11:01:18 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2SH19OD017498
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 11:01:18 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2SH1SRU017351
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 11:01:29 -0600
Message-ID: <4F7343CB.2070108@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2012 22:30:59 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Fwd: RE: Fwd: Re: makedumpfile security key enhancement using SIAL
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Luc Chouinard <LChouinard@s2sys.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, David Anderson <anderson@redhat.com>

Thanks Luc. We will let you know if in case we need any info/help.

I am also forwarding this mail to kexec mailing list.

Regards,
Aravinda


-------- Original Message --------
Subject: RE: Fwd: Re: makedumpfile security key enhancement using SIAL
Date: Wed, 28 Mar 2012 07:07:49 -0400
From: Luc Chouinard <LChouinard@s2sys.com>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

  Libsial is meant to be a pluggable entity and as such should not 
require other pieces to be there ( crash or gdb).
I want to create project and associated git for the library soon. For 
now you can extract libsial from the crash tar ball and manage any 
modifications using a simple patch mechanism. When the git is available, 
we can merge any fixes or enhancements you created for support of 
makedumpfile.

Makedumpfile and crash would then feed off of specific branches/versions 
of the git repository.
If you have any suggestions or want to help in setting up a public git / 
project page for sial, please let me know.


    -Luc

> -----Original Message-----
> From: Aravinda Prasad [mailto:aravinda@linux.vnet.ibm.com]
> Sent: Wednesday, March 28, 2012 1:31 AM
> To: Luc Chouinard
> Subject: Fwd: Fwd: Re: makedumpfile security key enhancement using SIAL
>
> Forwarding to your s2sys email ID. Details in mail forward.
>
> Regards,
> Aravinda
>
>
> -------- Original Message --------
> Subject: Fwd: Re: makedumpfile security key enhancement using SIAL
> Date: Tue, 20 Mar 2012 17:28:21 +0530
> From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> To: Luc Chouinard <lucchouina@yahoo.com>
> CC: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>,  Masaki Tachibana
> <tachibana@mxm.nes.nec.co.jp>, Mahesh J Salgaonkar
> <mahesh@linux.vnet.ibm.com>,  Ananth N Mavinakayanahalli
> <ananth@in.ibm.com>, Dave Anderson <anderson@redhat.com>
>
> Hi Luc,
>
> We are looking for utilising SIAL as a language construct for the makedumpfile
> kernel data filtering from vmcore feature. The details of which are in the mail
> forward.
>
> The proposed enhancement will require libsial.a and as SIAL is not currently
> built/shipped, we are looking for possibilities on how libsial.a can be made
> available to makedumpfile. Please let us know your opinion on the same.
>
> Regards,
> Aravinda
>
>
> -------- Original Message --------
> Subject: Re: makedumpfile security key enhancement using SIAL
> Date: Tue, 13 Mar 2012 10:27:43 -0400 (EDT)
> From: Dave Anderson <anderson@redhat.com>
> To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> CC: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>,         Masaki
> Tachibana <tachibana@mxm.nes.nec.co.jp>,        Ananth N
> Mavinakayanahalli <ananth@in.ibm.com>,        Mahesh J Salgaonkar
> <mahesh@linux.vnet.ibm.com>
>
>
>
> ----- Original Message -----
> > Hi Dave,
> >
> > Last year, we worked on the makedumpfile security key filtering where
> > we added support to filter out kernel data from vmcore. This year, we
> > are working on enhancing the framework to provide more flexibility for
> > the customers to specify rules to traverse and filter out kernel data
> > - for which we are planning to use SIAL.
> >
> > We are looking into using SIAL as language construct to specify
> > rules/commands to erase data in the image file. The makedumpfile would
> > interpret the rules provided in SIAL macro using SIAL library (which
> > could be dynamically loaded) and erase out suitable data in the vmcore.
> > We are planning to reuse SIAL as it provides a C language like
> > construct, which is flexible and powerful enough to specify rules to
> > erase data in vmcore.
> >
> > As SIAL is not built and shipped along with crash, we are looking for
> > possibilities on how SIAL can be leveraged by makedumpfile and would
> > like to know your opinion.
>
> Sorry but I cannot give you any help with SIAL.  Luc Chouinard is the maintainer
> of the SIAL extension module adaptation for the crash utility, and he can answer
> your questions w/respect to adapting it for makedumpfile.
> And ultimately, that's a question for the makedumpfile maintainers.
>
> Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
