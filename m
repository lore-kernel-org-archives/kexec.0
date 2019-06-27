Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from namei.org ([65.99.196.166])
 by casper.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hgMVG-0006Wi-27
 for kexec@lists.infradead.org; Thu, 27 Jun 2019 04:59:24 +0000
Date: Thu, 27 Jun 2019 14:59:09 +1000 (AEST)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH V34 09/29] kexec_file: Restrict at runtime if the kernel
 is locked down
In-Reply-To: <20190622000358.19895-10-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1906271423070.16512@namei.org>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-10-matthewgarrett@google.com>
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
To: Matthew Garrett <matthewgarrett@google.com>
Cc: Jiri Bohac <jbohac@suse.cz>, linux-api@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org

On Fri, 21 Jun 2019, Matthew Garrett wrote:

> From: Jiri Bohac <jbohac@suse.cz>
> 
> When KEXEC_SIG is not enabled, kernel should not load images through
> kexec_file systemcall if the kernel is locked down.

This is not a criticism of the patch but a related issue which I haven't 
seen discussed (apologies if it has).

If signed code is loaded into ring 0, verified by the kernel, then 
executed, you still lose your secure/trusted/verified boot state. If the 
currently running kernel has been runtime-compromised, any signature 
verification performed by the kernel cannot be trusted.

This problem is out of scope for the lockdown threat model (which 
naturally cannot include a compromised kernel), but folk should be aware 
that signature-verified kexec does not provide equivalent assurance to a 
full reboot on a secure-boot system.

Potential mitigations here include runtime integrity verification of the
kernel via a separate security monitor (hypervisor, SMM, TEE etc.) or some
kind of platform support for kexec verification.


-- 
James Morris
<jmorris@namei.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
