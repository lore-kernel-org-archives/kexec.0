Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-db8lp0185.outbound.messaging.microsoft.com
 ([213.199.154.185] helo=db8outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIQPH-0003N7-Nd
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 21:18:49 +0000
From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
Date: Wed, 20 Mar 2013 21:18:10 +0000
Message-ID: <1363814289.2553.41.camel@x230.sbx07502.somerma.wayport.net>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
 <alpine.LRH.2.02.1303191542200.30973@tundra.namei.org>
 <1363797717.2580.10.camel@falcor1.watson.ibm.com>
 <1363798166.2553.29.camel@x230.sbx07502.somerma.wayport.net>
 <1363802506.2580.55.camel@falcor1.watson.ibm.com>
 <1363803158.2553.33.camel@x230.sbx07502.somerma.wayport.net>
 <1363806968.2580.86.camel@falcor1.watson.ibm.com>
 <1363811856.2553.37.camel@x230.sbx07502.somerma.wayport.net>
 <1363813877.2580.120.camel@falcor1.watson.ibm.com>
In-Reply-To: <1363813877.2580.120.camel@falcor1.watson.ibm.com>
Content-Language: en-US
Content-ID: <9835E61BBA08494EBCDF231A480EE45B@namprd05.prod.outlook.com>
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
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Wed, 2013-03-20 at 17:11 -0400, Mimi Zohar wrote:
> On Wed, 2013-03-20 at 20:37 +0000, Matthew Garrett wrote:
> > Right, that'd be the rough idea. Any further runtime policy updates
> > would presumably need to be signed with a trusted key.
> 
> I'm really sorry to belabor this point, but can kexec rely on an LSM
> label to identify a specific file, out of all the files being executed,
> in a secure boot environment?  The SELinux integrity rule for kexec
> would then look something like,
>
> appraise func=BPRM_CHECK obj_type=kdump_exec_t appraise_type=imasig

It would certainly be possible to configure a system such that this was
true (assuming support for signed initramfs and restricted policy
loading), and anyone wanting to ensure that kexec only loaded trusted
binaries would have to ensure that their system was appropriately
configured. Having some mechanism to then give the kexec binary
CAP_MODIFY_KERNEL would avoid needing an extra kexec entry point.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
