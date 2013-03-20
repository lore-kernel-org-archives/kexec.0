Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UINPz-0002BU-Gk
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 18:07:20 +0000
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 20 Mar 2013 14:07:17 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2DF0E6E806B
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 14:07:11 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2KI7Ckg236506
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 14:07:13 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2KI6o99016407
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 12:06:50 -0600
Message-ID: <1363802506.2580.55.camel@falcor1.watson.ibm.com>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Wed, 20 Mar 2013 14:01:46 -0400
In-Reply-To: <1363798166.2553.29.camel@x230.sbx07502.somerma.wayport.net>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
 <alpine.LRH.2.02.1303191542200.30973@tundra.namei.org>
 <1363797717.2580.10.camel@falcor1.watson.ibm.com>
 <1363798166.2553.29.camel@x230.sbx07502.somerma.wayport.net>
Mime-Version: 1.0
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
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

On Wed, 2013-03-20 at 16:49 +0000, Matthew Garrett wrote:
> On Wed, 2013-03-20 at 12:41 -0400, Mimi Zohar wrote:
> 
> > Matthrew, perhaps you could clarify whether this will be tied to MAC
> > security.  Based on the kexec thread, I'm under the impression that is
> > not the intention, or at least not for kexec.  As root isn't trusted,
> > neither is the boot command line, nor any policy that is loaded by root,
> > including those for MAC.
> 
> The work done on signed initramfs fragments would seem to be the best
> option here so far?

Sorry, I'm not sure to which work you're referring. If you're referring
to Dmitry's "initramfs with digital signature protection" patches, then
we're speaking about enforcing integrity, not MAC security.  

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
