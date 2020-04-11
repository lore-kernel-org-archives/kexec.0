Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Sat, 11 Apr 2020 10:30:09 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
Message-ID: <20200411093009.GH25745@shell.armlinux.org.uk>
References: <a21d90ea-2566-a2bc-ad2f-6464a416c97f@arm.com>
 <9cb4ea0d-34c3-de42-4b3f-ee25a59c4835@redhat.com>
 <b0443908-e36f-9bc4-4a8a-4206cb782d4b@arm.com>
 <72672e2c-a57a-8df9-0cff-8035cbce7740@redhat.com>
 <34274b02-60ba-eb78-eacd-6dc1146ed3cd@arm.com>
 <80e4d1d7-f493-3f66-f700-86f18002d692@redhat.com>
 <dfacf85f-d79d-8742-7a13-1ac0a67bad04@arm.com>
 <ba481c82-c69e-043c-4b66-2d2c7732cf07@redhat.com>
 <20200410121013.03b609fd572504c03a666f4a@linux-foundation.org>
 <20200411034414.GH2129@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200411034414.GH2129@MiWiFi-R3L-srv>
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
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, David Hildenbrand <david@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, James Morse <james.morse@arm.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

On Sat, Apr 11, 2020 at 11:44:14AM +0800, Baoquan He wrote:
> Because We tend to use kexec_file_load more and improve/enhance it in the
> future, and gradually obsolete the old kexec_load interface which this
> patchset is trying to fix on. 

That's not going to happen; 32-bit ARM kexec uses the kexec_load
interface rather than the kexec_file_load version, and I see no one
with any interest in changing that - and there's users of the former.

I don't see how it's possible to convert 32-bit ARM kexec to the
kexec_file_load interface - this assumes that all you have are the
kernel, initrd, and commandline, but on 32-bit ARM kexec, we have
kernel, initrd and the dtb blob which the user can specify.

So, if we wanted to obsolete the kexec_load interface, _first_ there
needs to be a way to provide users with the existing functionality
they have already in place on 32-bit ARM - otherwise we're looking
at a userspace regression.  Especially as kexec_file_load takes
precedence on some distro patched versions of the kexec tool,
irrespective of which interface the user requests of the tool.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
