Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e37.co.us.ibm.com ([32.97.110.158])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIOUw-0000Xk-NF
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 19:16:32 +0000
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 20 Mar 2013 13:16:27 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D2B421FF0044
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 13:11:25 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2KJGEgc152688
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 13:16:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2KJGD6C009876
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 13:16:13 -0600
Message-ID: <1363806968.2580.86.camel@falcor1.watson.ibm.com>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Wed, 20 Mar 2013 15:16:08 -0400
In-Reply-To: <1363803158.2553.33.camel@x230.sbx07502.somerma.wayport.net>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
 <alpine.LRH.2.02.1303191542200.30973@tundra.namei.org>
 <1363797717.2580.10.camel@falcor1.watson.ibm.com>
 <1363798166.2553.29.camel@x230.sbx07502.somerma.wayport.net>
 <1363802506.2580.55.camel@falcor1.watson.ibm.com>
 <1363803158.2553.33.camel@x230.sbx07502.somerma.wayport.net>
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

On Wed, 2013-03-20 at 18:12 +0000, Matthew Garrett wrote:
> On Wed, 2013-03-20 at 14:01 -0400, Mimi Zohar wrote:
> 
> > Sorry, I'm not sure to which work you're referring. If you're referring
> > to Dmitry's "initramfs with digital signature protection" patches, then
> > we're speaking about enforcing integrity, not MAC security.  
> 
> Well, in the absence of hardcoded in-kernel policy, there needs to be
> some mechanism for ensuring the integrity of a policy. Shipping a signed
> policy initramfs fragment and having any Secure Boot bootloaders pass a
> flag in bootparams indicating that the kernel should panic if that
> fragment isn't present would seem to be the easiest way of doing that.
> Or have I misunderstood the question?

Ok, I was confused by the term "fragmented" initramfs.  So once you have
verified the "early" fragmented initramfs signature, this initramfs will
load the "trusted" public keys and could also load the MAC policy. (I
realize that dracut is currently loading the MAC policy, not the
initramfs.)  The MAC policy would then be trusted, right?  Could we then
use the LSM labels for defining an integrity policy for kexec?

thanks,

Mimi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
