Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1449772308.24127.59.camel@infradead.org>
Subject: Re: [PATCH v12 04/16] arm64: kvm: allows kvm cpu hotplug
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 10 Dec 2015 10:31:48 -0800
In-Reply-To: <56604A6E.60102@arm.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <23ca498d5e28017549c6076812d60b18e86fa20e.1448403503.git.geoff@infradead.org>
 <CAJ5Y-eYHqQCf=ZQzXb=D_P7VscM=vNc3YpYLJs+UtZLFswiaeQ@mail.gmail.com>
 <56604A6E.60102@arm.com>
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
To: Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, vikrams@codeaurora.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, shankerd@codeaurora.org, Christoffer Dall <christoffer.dall@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi All,

On Thu, 2015-12-03 at 13:58 +0000, Marc Zyngier wrote:
> Indeed, this is completely broken (I just reproduced the issue on a
> model).

There are users out there that want kexec/kdump support.  I think we
should remove this patch from the series, replace it with a temporary
Kconfig conditional that allows only one of KVM or kexec to be enabled,
and merge kexec and kdump support in for 4.5.  This will satisfy users
who need kexec but not KVM, like kexec based bootloaders.  Once this
KVM hot plug patch is fixed we then merge it, either for 4.5 or 4.6,
depending on the timing.

I'll prepare and post a v13 series that does the above.

-Geoff 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
