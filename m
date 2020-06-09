Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.11.71.1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiWp1-0000ua-F2
 for kexec@lists.infradead.org; Tue, 09 Jun 2020 05:29:16 +0000
From: Michael Ellerman <patch-notifications@ellerman.id.au>
In-Reply-To: <1585749644-4148-1-git-send-email-kernelfans@gmail.com>
References: <48c1b852-28e0-9c46-cafa-7c5992f966a7@linux.ibm.com>
 <1585749644-4148-1-git-send-email-kernelfans@gmail.com>
Subject: Re: [PATCHv4] powerpc/crashkernel: take "mem=" option into account
Message-Id: <159168034259.1381411.9724380160125554368.b4-ty@ellerman.id.au>
Date: Tue,  9 Jun 2020 15:28:56 +1000 (AEST)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org, Pingfan Liu <kernelfans@gmail.com>
Cc: kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>

On Wed, 1 Apr 2020 22:00:44 +0800, Pingfan Liu wrote:
> 'mem=" option is an easy way to put high pressure on memory during some
> test. Hence after applying the memory limit, instead of total mem, the
> actual usable memory should be considered when reserving mem for
> crashkernel. Otherwise the boot up may experience OOM issue.
> 
> E.g. it would reserve 4G prior to the change and 512M afterward, if passing
> crashkernel="2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G", and
> mem=5G on a 256G machine.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/crashkernel: Take "mem=" option into account
      https://git.kernel.org/powerpc/c/be5470e0c285a68dc3afdea965032f5ddc8269d7

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
