Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VgGko-0003c2-4L
 for kexec@lists.infradead.org; Tue, 12 Nov 2013 16:23:50 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: The kernel version is not supported
Date: Tue, 12 Nov 2013 17:23:25 +0100
Message-ID: <2415548.dh2jmZ1ojx@skinner>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: lkundrak@v3.sk, kexec@lists.infradead.org

Hi,

there was a patch recently from Lubomir, title:
dump-dmesg: Understand >= v3.11-rc4 dmesg

But in makedumpfile.h the latest supported version still is:
#define LATEST_VERSION          KERNEL_VERSION(3, 9, 6)/* linux-3.9.6 */

resulting in:
The kernel version is not supported.
The created dumpfile may be incomplete.

messages.

I wonder whether there are other known issues with latest
kernels which are the reason LATEST_VERSION did not get increased
and which are those?

I also wonder what the concept of LATEST_VERSION is.
One does not know in advance which change in a newer kernel version
might break things?
So this one needs to be increased with every new kernel version?

Thanks for any hints,

     Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
