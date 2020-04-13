Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 13 Apr 2020 16:01:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
Message-Id: <20200413160144.0e07c0033afc474228bc9218@linux-foundation.org>
In-Reply-To: <871rorjzmc.fsf@x220.int.ebiederm.org>
References: <34274b02-60ba-eb78-eacd-6dc1146ed3cd@arm.com>
 <80e4d1d7-f493-3f66-f700-86f18002d692@redhat.com>
 <dfacf85f-d79d-8742-7a13-1ac0a67bad04@arm.com>
 <ba481c82-c69e-043c-4b66-2d2c7732cf07@redhat.com>
 <20200410121013.03b609fd572504c03a666f4a@linux-foundation.org>
 <20200411034414.GH2129@MiWiFi-R3L-srv>
 <20200411093009.GH25745@shell.armlinux.org.uk>
 <20200412053507.GA4247@MiWiFi-R3L-srv>
 <20200412080836.GM25745@shell.armlinux.org.uk>
 <87wo6klbw0.fsf@x220.int.ebiederm.org>
 <20200413023701.GA20265@MiWiFi-R3L-srv>
 <871rorjzmc.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
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
Cc: Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, kexec@lists.infradead.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>, linux-mm@kvack.org, James Morse <james.morse@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

On Mon, 13 Apr 2020 08:15:23 -0500 ebiederm@xmission.com (Eric W. Biederman) wrote:

> > For 3), people can still use kexec_load and develop/fix for it, if no
> > kexec_file_load supported. But 32-bit arm should be a different one,
> > more like i386, we will leave it as is, and fix anything which could
> > break it. But people really expects to improve or add feature to it? E.g
> > in this patchset, the mem hotplug issue James raised, I assume James is
> > focusing on arm64, x86_64, but not 32-bit arm. As DavidH commented in
> > another reply, people even don't agree to continue supporting memory
> > hotplug on 32-bit system. We ever took effort to fix a memory hotplug
> > bug on i386 with a patch, but people would rather set it as BROKEN.
> 
> For memory hotplug just reload.  Userspace already gets good events.
> 
> We should not expect anything except a panic kernel to be loaded over a
> memory hotplug event. The kexec on panic code should actually be loaded
> in a location that we don't reliquish if asked for it.

Is that a nack for James's patchset?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
