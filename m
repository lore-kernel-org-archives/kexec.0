Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1412707320.32313.100.camel@smoke>
Subject: Re: [PATCH 6/7] arm64/kexec: Add core kexec support
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 07 Oct 2014 11:42:00 -0700
In-Reply-To: <20141007134450.GE27464@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com> <1412106877.6630.45.camel@smoke>
 <20141001145602.GB13689@redhat.com> <1412361303.32313.24.camel@smoke>
 <20141007134450.GE27464@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

Hi Vivek,

On Tue, 2014-10-07 at 09:44 -0400, Vivek Goyal wrote:
> So as Mark and I discussed need of purgatory code in other mails, are you
> plannign to enable purgatory on arm64.

Adding purgatory code to arm64 is low priority, and I currently
have no plan to do that.  Users are asking for kdump, and proper
UEFI support, so that is what I will work towards.

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
