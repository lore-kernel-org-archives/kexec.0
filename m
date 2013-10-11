Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VUZ1w-0001fc-Gp
 for kexec@lists.infradead.org; Fri, 11 Oct 2013 09:29:08 +0000
Date: Fri, 11 Oct 2013 11:28:37 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: kexec: Clearing registers just before jumping into purgatory
Message-ID: <20131011092837.GZ3626@debian70-amd64.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
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
To: ebiederm@xmission.com, hbabu@us.ibm.com, hpa@linux.intel.com, keescook@chromium.org, vgoyal@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: keir@xen.org, david.vrabel@citrix.com, jbeulich@suse.com, xen-devel@lists.xen.org

Hi,

Could you explain why do you clear all registers just before jumping
into purgatory (please look into arch/x86/kernel/relocate_kernel_64.S
for more details)? There is no any single word about that. I do not
count comment which states what is going on. purgatory on entry does
not assume any value in registers. Are you going to use that feature
for something in the future (e.g. to differentiate between callers
and/or Linux versions if it be needed)?

By the way, interestingly it is not done if preserve_context is in force.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
