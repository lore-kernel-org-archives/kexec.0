Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1417551727.7724.0.camel@infradead.org>
Subject: Re: [PATCH 0/8] arm64 kexec kernel patches V6
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 02 Dec 2014 12:22:07 -0800
In-Reply-To: <20141127061947.GB2860@darkstar.nay.redhat.com>
References: <cover.1415926876.git.geoff@infradead.org>
 <20141127061947.GB2860@darkstar.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: drjones@redhat.com, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, christoffer.dall@linaro.org, Grant Likely <grant.likely@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Dave,

On Thu, 2014-11-27 at 14:19 +0800, Dave Young wrote:
> Is there any Linaro card for the KVM soft restart issue?

  https://cards.linaro.org/browse/KWG-611

I have a skeleton patch for the fix that needs to be filled
out in both in the Linaro card and in the commit (arm64/kvm:
Add KVM cpu shutdown) my master branch here:

 http://git.linaro.org/people/geoff.levand/linux-kexec.git

-Geoff




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
