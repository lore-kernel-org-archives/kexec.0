Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMLrd-0002jI-P3
 for kexec@lists.infradead.org; Thu, 09 Apr 2020 01:20:19 +0000
Date: Thu, 9 Apr 2020 09:20:02 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 0/3] KVM: VMX: Fix for kexec VMCLEAR and VMXON cleanup
Message-ID: <20200409012002.GT2402@MiWiFi-R3L-srv>
References: <20200321193751.24985-1-sean.j.christopherson@intel.com>
 <20200407110115.GA14381@MiWiFi-R3L-srv>
 <87r1wzlcwn.fsf@vitty.brq.redhat.com>
 <20200408151808.GS2402@MiWiFi-R3L-srv>
 <87mu7l2256.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mu7l2256.fsf@vitty.brq.redhat.com>
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
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: dzickus@redhat.com, Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, dyoung@redhat.com, Jim Mattson <jmattson@google.com>

On 04/08/20 at 09:44pm, Vitaly Kuznetsov wrote:
> Baoquan He <bhe@redhat.com> writes:
> 
> > On 04/07/20 at 02:04pm, Vitaly Kuznetsov wrote:
> >> Baoquan He <bhe@redhat.com> writes:
> >> 
> >> >
> >> > The trace is here. 
> >> >
> >> > [  132.480817] RIP: 0010:crash_vmclear_local_loaded_vmcss+0x57/0xd0 [kvm_intel] 
> >> 
> >> This is a known bug,
> >> 
> >> https://lore.kernel.org/kvm/20200401081348.1345307-1-vkuznets@redhat.com/
> >
> > Thanks for telling, Vitaly.
> >
> > I tested your patch, it works.
> >
> > One thing is I noticed a warning message when your patch is applied. When
> > I changed back to revert this patchset, didn't found this message. I didn't
> > look into the detail of network core code and the kvm vmx code, maybe it's
> > not relevant.
> >
> >
> > [ 3708.629234] Type was not set for devlink port.
> > [ 3708.629258] WARNING: CPU: 3 PID: 60 at net/core/devlink.c:7164 devlink_port_type_warn+0x11/0x20
> > [ 3708.632328] Modules linked in: rfkill sunrpc intel_powerclamp coretemp kvm_intel kvm irqbypass intel_cstate iTCO_wdt hpwdt intel_uncore gpio_ich iTCO_vendor_support pcspkr ipmi_ssif hpilo lpc_ich ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter pcc_cpufreq i7core_edac ip_tables xfs libcrc32c radeon i2c_algo_bit drm_kms_helper cec ttm crc32c_intel serio_raw drm ata_generic pata_acpi mlx4_core bnx2 hpsa scsi_transport_sas
> > [ 3708.640782] CPU: 3 PID: 60 Comm: kworker/3:1 Kdump: loaded Tainted: G          I       5.6.0+ #1
> > [ 3708.642715] Hardware name: HP ProLiant DL380 G6, BIOS P62 08/16/2015
> > [ 3708.644222] Workqueue: events devlink_port_type_warn
> > [ 3708.645349] RIP: 0010:devlink_port_type_warn+0x11/0x20
> 
> What's in the patchset you're testing? Is it Sean's series + my patch,
> or just my patch? In case it's the later I'm having hard times trying to
> see how this can be related, but in case it's the former the fact that
> we do stuff a little bit differently on kexec may actually be triggering
> the issue above. I still think that it's not causing it, just
> triggering.

I am testing on Linus's tree, this patchset is already there. I just
reverted these patchset, or apply your patch on top of it. Both of them
works. The devlink warning message is not related to this issue because
I found it too when this patchset are reverted.

While I would suggest adding kexec@lists.infradead.org when code changes
are related to kexec/kdump since we usually watch this mailing list.
LKML contains too many mails, we may miss this kind of change, have to
debug and test again. Thanks.

Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
