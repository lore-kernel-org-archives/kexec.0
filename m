Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 1 Sep 2020 18:13:07 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v11 5/5] kdump: update Documentation about crashkernel
Message-ID: <20200901171306.GK5561@gaia>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com>
 <20200808100239.GB60590@dhcp-128-65.nay.redhat.com>
 <96d0da23-d484-7f66-1680-07b4b5984831@huawei.com>
 <20200810060355.GB6988@dhcp-128-65.nay.redhat.com>
 <2e6aebf9-3765-5d8c-933c-698442db1d52@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2e6aebf9-3765-5d8c-933c-698442db1d52@huawei.com>
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
To: chenzhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, Dave Young <dyoung@redhat.com>, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On Tue, Aug 18, 2020 at 03:07:04PM +0800, chenzhou wrote:
> On 2020/8/10 14:03, Dave Young wrote:
> >>> Previously I remember we talked about to use similar logic as X86, but I
> >>> remember you mentioned on some arm64 platform there could be no low
> >>> memory at all.  Is this not a problem now for the fallback?  Just be
> >>> curious, thanks for the update, for the common part looks good.
> >>
> >> Did you mean this discuss: https://lkml.org/lkml/2019/12/27/122?
> > I meant about this reply instead :)
> > https://lkml.org/lkml/2020/1/16/616
> 
> Sorry for not repley in time, I was on holiday last week.
> 
> The platform James mentioned may exist for which have no devices and
> need no low memory.

If there is no memory below 4GB, the arm64 kernel assumes that the
32-bit devices will have some DMA offsets shifting the addresses to the
bottom of the available RAM. So even if RAM starts above 4GB, we
ZONE_DMA32 will be allocated in the bottom 4GB of the high memory (and
if the hardware designers forgot to shift those DMA accesses, we don't
have to support the platform ;)).

So the arm64 notion of low memory differs slightly from the x86 one.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
