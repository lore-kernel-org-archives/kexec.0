Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bfCTV-0008DO-Ey
 for kexec@lists.infradead.org; Wed, 31 Aug 2016 20:51:10 +0000
Date: Wed, 31 Aug 2016 13:50:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
Message-Id: <20160831135047.4b05a7f912f158ed5f888241@linux-foundation.org>
In-Reply-To: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-security-module <linux-security-module@vger.kernel.org>, linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>

On Tue, 30 Aug 2016 18:40:02 -0400 Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> The TPM PCRs are only reset on a hard reboot.  In order to validate a
> TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
> of the running kernel must be saved and then restored on the subsequent
> boot, possibly of a different architecture.
> 
> The existing securityfs binary_runtime_measurements file conveniently
> provides a serialized format of the IMA measurement list. This patch
> set serializes the measurement list in this format and restores it.
> 
> Up to now, the binary_runtime_measurements was defined as architecture
> native format.  The assumption being that userspace could and would
> handle any architecture conversions.  With the ability of carrying the
> measurement list across kexec, possibly from one architecture to a
> different one, the per boot architecture information is lost and with it
> the ability of recalculating the template digest hash.  To resolve this
> problem, without breaking the existing ABI, this patch set introduces
> the boot command line option "ima_canonical_fmt", which is arbitrarily
> defined as little endian.
> 
> The need for this boot command line option will be limited to the
> existing version 1 format of the binary_runtime_measurements.
> Subsequent formats will be defined as canonical format (eg. TPM 2.0
> support for larger digests).
> 
> This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
> hand-over for the next kernel" patch set. 
> 
> These patches can also be found in the next-kexec-restore branch of:
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

I'll merge these into -mm to get some linux-next exposure.  I don't
know what your upstream merge planes will be?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
