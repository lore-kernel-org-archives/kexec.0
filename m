Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]
 helo=ch1outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIPle-0006bL-Ll
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 20:37:52 +0000
From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
Date: Wed, 20 Mar 2013 20:37:36 +0000
Message-ID: <1363811856.2553.37.camel@x230.sbx07502.somerma.wayport.net>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
 <alpine.LRH.2.02.1303191542200.30973@tundra.namei.org>
 <1363797717.2580.10.camel@falcor1.watson.ibm.com>
 <1363798166.2553.29.camel@x230.sbx07502.somerma.wayport.net>
 <1363802506.2580.55.camel@falcor1.watson.ibm.com>
 <1363803158.2553.33.camel@x230.sbx07502.somerma.wayport.net>
 <1363806968.2580.86.camel@falcor1.watson.ibm.com>
In-Reply-To: <1363806968.2580.86.camel@falcor1.watson.ibm.com>
Content-Language: en-US
Content-ID: <C17806DEE14C634C8D6F11E7ECF7DD2B@namprd05.prod.outlook.com>
MIME-Version: 1.0
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

On Wed, 2013-03-20 at 15:16 -0400, Mimi Zohar wrote:
> On Wed, 2013-03-20 at 18:12 +0000, Matthew Garrett wrote:
> > Well, in the absence of hardcoded in-kernel policy, there needs to be
> > some mechanism for ensuring the integrity of a policy. Shipping a signed
> > policy initramfs fragment and having any Secure Boot bootloaders pass a
> > flag in bootparams indicating that the kernel should panic if that
> > fragment isn't present would seem to be the easiest way of doing that.
> > Or have I misunderstood the question?
> 
> Ok, I was confused by the term "fragmented" initramfs.  So once you have
> verified the "early" fragmented initramfs signature, this initramfs will
> load the "trusted" public keys and could also load the MAC policy. (I
> realize that dracut is currently loading the MAC policy, not the
> initramfs.)  The MAC policy would then be trusted, right?  Could we then
> use the LSM labels for defining an integrity policy for kexec?

Right, that'd be the rough idea. Any further runtime policy updates
would presumably need to be signed with a trusted key.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
