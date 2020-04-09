Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMV8d-00088g-J2
 for kexec@lists.infradead.org; Thu, 09 Apr 2020 11:14:29 +0000
Received: by mail-wr1-f70.google.com with SMTP id t8so260360wrq.22
 for <kexec@lists.infradead.org>; Thu, 09 Apr 2020 04:14:17 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v2 0/3] KVM: VMX: Fix for kexec VMCLEAR and VMXON cleanup
In-Reply-To: <20200409012002.GT2402@MiWiFi-R3L-srv>
References: <20200321193751.24985-1-sean.j.christopherson@intel.com>
 <20200407110115.GA14381@MiWiFi-R3L-srv> <87r1wzlcwn.fsf@vitty.brq.redhat.com>
 <20200408151808.GS2402@MiWiFi-R3L-srv> <87mu7l2256.fsf@vitty.brq.redhat.com>
 <20200409012002.GT2402@MiWiFi-R3L-srv>
Date: Thu, 09 Apr 2020 13:14:14 +0200
Message-ID: <87imi829o9.fsf@vitty.brq.redhat.com>
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
> While I would suggest adding kexec@lists.infradead.org when code changes
> are related to kexec/kdump since we usually watch this mailing list.
> LKML contains too many mails, we may miss this kind of change, have to
> debug and test again.
>

Definitely makes sense and I'll try my best to remember doing this
myself next time but the problem is that scripts/checkpatch.pl is not
smart enough, kexec related bits are scattered all over kernel and
drivers so I'm afraid you're missing a lot in kexec@ :-(

-- 
Vitaly


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
