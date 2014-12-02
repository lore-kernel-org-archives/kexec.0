Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1417551964.7724.2.camel@infradead.org>
Subject: Re: [PATCH 0/8] arm64 kexec kernel patches V6
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 02 Dec 2014 12:26:04 -0800
In-Reply-To: <20141128065636.GA3676@darkstar.nay.redhat.com>
References: <cover.1415926876.git.geoff@infradead.org>
 <20141127061947.GB2860@darkstar.nay.redhat.com>
 <20141128065636.GA3676@darkstar.nay.redhat.com>
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

On Fri, 2014-11-28 at 14:56 +0800, Dave Young wrote:
> Tested your master branch, works for me with below setup:
> UEFI boot, CONFIG_KVM=n, maxcpus=1, --lite
> 
> But --dtb still does not work if there's no /proc/device-tree, failed as below:
> unrecoverable error: could not scan "/proc/device-tree/": No such file or directory.
> 
> kexec without --lite also does not work, looks like it hangs after "Bye" ..

I'll be away from the office this week.  I'll look into this when I
return.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
