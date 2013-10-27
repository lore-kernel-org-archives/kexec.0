Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VaI05-0002Au-1E
 for kexec@lists.infradead.org; Sun, 27 Oct 2013 04:30:54 +0000
Date: Sun, 27 Oct 2013 12:30:23 +0800
From: Dave Young <dyoung@redhat.com>
Subject: query for idea about a kexec regression
Message-ID: <20131027043023.GA18689@dhcp-16-126.nay.redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: x86@vger.kernel.org, kexec@lists.infradead.org

Hi

While I testing efi runtime patches for kexec kernel, there's
2 machines kexec fails on them. It can be reproduced with
non-efi kernel, so it's not related to the patchset.

Problem is kexec kernel will immediatly reboot after below
kernel message:
smpboot: Booting Node   0, Processors  #   1

The latter CPUs were not printed.

nr_cpus=1 works, so there might be some bug on smp code.

Any idea or suspection acout some patches? This is not 100%
reproducible, to me it's about 30% thus it's hard to bisect.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
