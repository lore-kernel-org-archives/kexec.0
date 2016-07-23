Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bR62p-0005nh-1O
 for kexec@lists.infradead.org; Sat, 23 Jul 2016 23:09:19 +0000
Date: Sun, 24 Jul 2016 07:07:40 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] x86/apic: Clean up the apic delivery mode macro
 definition
Message-ID: <201607240725.hpXEwlCH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1468983483-3952-4-git-send-email-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: fenghua.yu@intel.com, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, kbuild-all@01.org, hpa@zytor.com, tglx@linutronix.de, weijg.fnst@cn.fujitsu.com, jiang.liu@linux.intel.com, vgoyal@redhat.com, ebiederm@xmission.com

Hi,

[auto build test WARNING on iommu/next]
[also build test WARNING on v4.7-rc7 next-20160722]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baoquan-He/Enable-legacy-irq-mode-before-jump-to-kexec-kdump-kernel/20160724-054857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:232:8: sparse: attribute 'no_sanitize_address': unknown attribute
   arch/x86/kvm/lapic.c:186:15: sparse: incompatible types in comparison expression (different address spaces)
   arch/x86/kvm/lapic.c:963:14: sparse: undefined identifier 'APIC_DM_EXTINT'
>> arch/x86/kvm/lapic.c:963:14: sparse: incompatible types for 'case' statement
   arch/x86/kvm/lapic.c:699:15: sparse: incompatible types in comparison expression (different address spaces)
   arch/x86/kvm/lapic.c:799:15: sparse: incompatible types in comparison expression (different address spaces)
   arch/x86/kvm/lapic.c:963:14: sparse: Expected constant expression in case statement
   arch/x86/kvm/lapic.c: In function '__apic_accept_irq':
   arch/x86/kvm/lapic.c:963:7: error: 'APIC_DM_EXTINT' undeclared (first use in this function)
     case APIC_DM_EXTINT:
          ^~~~~~~~~~~~~~
   arch/x86/kvm/lapic.c:963:7: note: each undeclared identifier is reported only once for each function it appears in

vim +/case +963 arch/x86/kvm/lapic.c

c5ec15340 drivers/kvm/lapic.c  He, Qing        2007-09-03  947  				   vcpu->vcpu_id);
c5ec15340 drivers/kvm/lapic.c  He, Qing        2007-09-03  948  		}
97222cc83 drivers/kvm/lapic.c  Eddie Dong      2007-09-12  949  		break;
97222cc83 drivers/kvm/lapic.c  Eddie Dong      2007-09-12  950  
97222cc83 drivers/kvm/lapic.c  Eddie Dong      2007-09-12  951  	case APIC_DM_STARTUP:
1b10bf31a arch/x86/kvm/lapic.c Jan Kiszka      2008-09-30  952  		apic_debug("SIPI to vcpu %d vector 0x%02x\n",
c5ec15340 drivers/kvm/lapic.c  He, Qing        2007-09-03  953  			   vcpu->vcpu_id, vector);
6da7e3f64 arch/x86/kvm/lapic.c Gleb Natapov    2009-03-05  954  		result = 1;
66450a21f arch/x86/kvm/lapic.c Jan Kiszka      2013-03-13  955  		apic->sipi_vector = vector;
66450a21f arch/x86/kvm/lapic.c Jan Kiszka      2013-03-13  956  		/* make sure sipi_vector is visible for the receiver */
66450a21f arch/x86/kvm/lapic.c Jan Kiszka      2013-03-13  957  		smp_wmb();
66450a21f arch/x86/kvm/lapic.c Jan Kiszka      2013-03-13  958  		set_bit(KVM_APIC_SIPI, &apic->pending_events);
3842d135f arch/x86/kvm/lapic.c Avi Kivity      2010-07-27  959  		kvm_make_request(KVM_REQ_EVENT, vcpu);
d76901750 arch/x86/kvm/lapic.c Marcelo Tosatti 2008-09-08  960  		kvm_vcpu_kick(vcpu);
97222cc83 drivers/kvm/lapic.c  Eddie Dong      2007-09-12  961  		break;
97222cc83 drivers/kvm/lapic.c  Eddie Dong      2007-09-12  962  
23930f952 arch/x86/kvm/lapic.c Jan Kiszka      2008-09-26 @963  	case APIC_DM_EXTINT:
23930f952 arch/x86/kvm/lapic.c Jan Kiszka      2008-09-26  964  		/*
23930f952 arch/x86/kvm/lapic.c Jan Kiszka      2008-09-26  965  		 * Should only be called by kvm_apic_local_deliver() with LVT0,
23930f952 arch/x86/kvm/lapic.c Jan Kiszka      2008-09-26  966  		 * before NMI watchdog was enabled. Already handled by
23930f952 arch/x86/kvm/lapic.c Jan Kiszka      2008-09-26  967  		 * kvm_apic_accept_pic_intr().
23930f952 arch/x86/kvm/lapic.c Jan Kiszka      2008-09-26  968  		 */
23930f952 arch/x86/kvm/lapic.c Jan Kiszka      2008-09-26  969  		break;
23930f952 arch/x86/kvm/lapic.c Jan Kiszka      2008-09-26  970  
97222cc83 drivers/kvm/lapic.c  Eddie Dong      2007-09-12  971  	default:

:::::: The code at line 963 was first introduced by commit
:::::: 23930f9521c9c4d4aa96cdb9d1e1703f3782bb94 KVM: x86: Enable NMI Watchdog via in-kernel PIT source

:::::: TO: Jan Kiszka <jan.kiszka@siemens.com>
:::::: CC: Avi Kivity <avi@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
