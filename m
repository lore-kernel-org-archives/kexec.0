Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLmym-0003sO-2W
 for kexec@lists.infradead.org; Tue, 07 Apr 2020 12:05:21 +0000
Received: by mail-wr1-f72.google.com with SMTP id y1so1647406wrp.5
 for <kexec@lists.infradead.org>; Tue, 07 Apr 2020 05:04:59 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v2 0/3] KVM: VMX: Fix for kexec VMCLEAR and VMXON cleanup
In-Reply-To: <20200407110115.GA14381@MiWiFi-R3L-srv>
References: <20200321193751.24985-1-sean.j.christopherson@intel.com>
 <20200407110115.GA14381@MiWiFi-R3L-srv>
Date: Tue, 07 Apr 2020 14:04:56 +0200
Message-ID: <87r1wzlcwn.fsf@vitty.brq.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: dzickus@redhat.com, Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, dyoung@redhat.com, Jim Mattson <jmattson@google.com>

Baoquan He <bhe@redhat.com> writes:

>
> The trace is here. 
>
> [  132.480817] RIP: 0010:crash_vmclear_local_loaded_vmcss+0x57/0xd0 [kvm_intel] 

This is a known bug,

https://lore.kernel.org/kvm/20200401081348.1345307-1-vkuznets@redhat.com/

-- 
Vitaly


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
