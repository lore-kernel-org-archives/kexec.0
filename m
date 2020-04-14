Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 0/3] kexec/memory_hotplug: Prevent removal and accidental
 use
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200330135522.GE6352@MiWiFi-R3L-srv>
 <2bdfbb1c-49da-d476-4a38-f91937105ae3@arm.com>
 <20200331034612.GB83248@dhcp-128-65.nay.redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <7cfeaf4e-a869-16be-3fe6-521a41d94508@arm.com>
Date: Tue, 14 Apr 2020 18:31:05 +0100
MIME-Version: 1.0
In-Reply-To: <20200331034612.GB83248@dhcp-128-65.nay.redhat.com>
Content-Language: en-GB
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
To: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

Hi Dave,

On 31/03/2020 04:46, Dave Young wrote:
> I agreed that file load is still not widely used,  but in the long run
> we should not maintain both of them all the future time.  Especially
> when some kernel-userspace interfaces need to be introduced, file load
> will have the natural advantage.  We may keep the kexec_load for other
> misc usecases, but we can use file load for the major modern
> linux-to-linux loading.  I'm not saying we can do it immediately, just
> thought we should reduce the duplicate effort and try to avoid hacking if
> possible.

Sure. My aim here is to never debug this problem again.


> Anyway about this particular issue, I wonder if we can just reload with
> a udev rule as replied in another mail.

What if it doesn't? I can't find such a rule on my debian machine.
I don't think user-space can be relied on for something like this.

The best we could hope for here is a dying gasp from the old kernel:
| kexec: memory layout changed since kexec load, this may not work.
| Bye!

... assuming anyone sees such a message.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
