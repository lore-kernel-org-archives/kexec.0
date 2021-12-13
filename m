Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 13 Dec 2021 19:57:02 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v17 00/10] support reserving crashkernel above 4G on
 arm64 kdump
Message-ID: <YbeXfkEkqp1Js3TP@zn.tnic>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <5ef3ef54-33db-3cb2-4908-8bd1254749e3@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5ef3ef54-33db-3cb2-4908-8bd1254749e3@oracle.com>
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
To: john.p.donnelly@oracle.com
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

On Mon, Dec 13, 2021 at 08:37:48AM -0600, john.p.donnelly@oracle.com wrote:
> After 2 years, and 17 versions, can we now get this series promoted into a
> build ?

For example:

$ ./scripts/get_maintainer.pl -f Documentation/admin-guide/kdump/kdump.rst
Baoquan He <bhe@redhat.com> (maintainer:KDUMP)
Vivek Goyal <vgoyal@redhat.com> (reviewer:KDUMP)
Dave Young <dyoung@redhat.com> (reviewer:KDUMP)
Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
kexec@lists.infradead.org (open list:KDUMP)

I see only two acks from Baoquan.

So yes, this needs to go through the normal review process first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
