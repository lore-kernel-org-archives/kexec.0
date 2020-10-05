Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 5 Oct 2020 18:09:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v12 0/9] support reserving crashkernel above 4G on arm64
 kdump
Message-ID: <20201005170937.GA14576@gaia>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <e9b1b5db-a848-468e-6baf-2f7b4d658805@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e9b1b5db-a848-468e-6baf-2f7b4d658805@oracle.com>
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
To: John Donnelly <john.p.donnelly@oracle.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, Chen Zhou <chenzhou10@huawei.com>, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On Sat, Sep 12, 2020 at 06:44:29AM -0500, John Donnelly wrote:
> On 9/7/20 8:47 AM, Chen Zhou wrote:
> > Chen Zhou (9):
> >    x86: kdump: move CRASH_ALIGN to 2M
> >    x86: kdump: make the lower bound of crash kernel reservation
> >      consistent
> >    x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
> >      reserve_crashkernel[_low]()
> >    x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
> >    arm64: kdump: introduce some macroes for crash kernel reservation
> >    arm64: kdump: reimplement crashkernel=X
> >    kdump: add threshold for the required memory
> >    arm64: kdump: add memory for devices by DT property
> >      linux,usable-memory-range
> >    kdump: update Documentation about crashkernel
[...]
> I did a brief unit-test on 5.9-rc4.
> 
> Please add:
> 
> Tested-by:  John Donnelly <John.p.donnelly@oracle.com>

Thanks for testing.

> This activity is over a year old. It needs accepted.

It's getting there, hopefully in 5.11. There are some minor tweaks to
address.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
