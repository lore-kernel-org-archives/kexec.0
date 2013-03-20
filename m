Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]
 helo=am1outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIKir-0006PK-8K
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 15:14:38 +0000
From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
Date: Wed, 20 Mar 2013 15:14:23 +0000
Message-ID: <1363792462.2553.24.camel@x230.sbx07502.somerma.wayport.net>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
 <51490ABD.3050205@zytor.com>
 <1363785354.2553.15.camel@x230.sbx07502.somerma.wayport.net>
 <db71c48c-4ec4-4611-935b-bb1b0441112d@email.android.com>
In-Reply-To: <db71c48c-4ec4-4611-935b-bb1b0441112d@email.android.com>
Content-Language: en-US
Content-ID: <1AD6EDAC38A33743BD554406165A81AD@namprd05.prod.outlook.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 2013-03-20 at 08:03 -0700, H. Peter Anvin wrote:
> CAP_SYS_RAWIO is definitely inappropriate there.

Ok. How do we fix that without breaking userspace that expects
CAP_SYS_RAWIO to be sufficient?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
