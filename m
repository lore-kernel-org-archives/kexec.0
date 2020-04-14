Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOI1S-0002bk-DQ
 for kexec@lists.infradead.org; Tue, 14 Apr 2020 09:38:27 +0000
Date: Tue, 14 Apr 2020 17:38:09 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
Message-ID: <20200414093809.GA43901@dhcp-128-65.nay.redhat.com>
References: <ba481c82-c69e-043c-4b66-2d2c7732cf07@redhat.com>
 <20200410121013.03b609fd572504c03a666f4a@linux-foundation.org>
 <20200411034414.GH2129@MiWiFi-R3L-srv>
 <20200411093009.GH25745@shell.armlinux.org.uk>
 <20200412053507.GA4247@MiWiFi-R3L-srv>
 <20200412080836.GM25745@shell.armlinux.org.uk>
 <87wo6klbw0.fsf@x220.int.ebiederm.org>
 <20200413023701.GA20265@MiWiFi-R3L-srv>
 <871rorjzmc.fsf@x220.int.ebiederm.org>
 <20200414091617.GA43656@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200414091617.GA43656@dhcp-128-65.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, David Hildenbrand <david@redhat.com>, kexec@lists.infradead.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>, linux-mm@kvack.org, James Morse <james.morse@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

> We do not remove kexec_load at all, it is indeed helpful in many cases
> as all agreed.  But if we have a bug reported for both we may fix
> kexec_file_load first because it is usually easier, also do not need to
> worry about too much about old kernel and new kernel compatibility.
> 
> For example the recent breakage we found in efi path, kexec_file_load
> just work after the efi cleanup, but kexec_load depends on the ABI we
> added, so we must fix it as below:
> https://lore.kernel.org/linux-efi/20200410135644.GB6772@dhcp-128-65.nay.redhat.com/ 

Also, we have some specific sysfs files exported for kexec-tools use
/sys/firmware/efi/runtime-map/* and a few other table addresses:
fw_vendor  runtime and config_table under /sys/firmware/efi

That is only used by userspace kexec_tools for kexec_load, now the
runtime field is useless because of Ard's cleanup in efi code, but we
have to keep it there, older kexec-tools will need it.

In this case kexec_file_load do not need those hacks at all.  So in the
future if we have to invent some kernel/userspace abi only for
kexec_load we should be careful and maybe reject if no strong reason. 

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
