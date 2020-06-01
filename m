Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 1 Jun 2020 08:34:48 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: kdump: Getting "warn_alloc" warning during boot of kdump kernel
Message-ID: <20200601073447.GC8601@willie-the-truck>
References: <CAJ2QiJJgw0Cm=XBeVvOJ8WnWB0Xfv3JEYKTQUovnwrrDw17w9g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJ2QiJJgw0Cm=XBeVvOJ8WnWB0Xfv3JEYKTQUovnwrrDw17w9g@mail.gmail.com>
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
To: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc: Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>, Catalin Marinas <catalin.marinas@arm.com>, kexec mailing list <kexec@lists.infradead.org>, Kamlakant Patel <kamlakantp@marvell.com>, Prabhakar Kushwaha <pkushwaha@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Fri, May 15, 2020 at 04:28:13PM +0530, Prabhakar Kushwaha wrote:
> We are getting "warn_alloc" warning during boot of kdump kernel. This
> warning is observed with latest upstream tag (v5.7-rc5).

Perhaps you can help to review:

https://lore.kernel.org/r/20200521093805.64398-1-chenzhou10@huawei.com

Since it looks like it should solve your problem.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
