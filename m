Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 14 Dec 2021 15:24:04 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
Message-ID: <YbipBGn5saLscIMn@zn.tnic>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
 <20211214085440.GA3023@MiWiFi-R3L-srv> <YbhmF3+AzvRtGimD@zn.tnic>
 <20211214095657.GB3023@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211214095657.GB3023@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

On Tue, Dec 14, 2021 at 05:56:57PM +0800, Baoquan He wrote:
> Ah, OK, I see the new paragraph from you added in below commit.

That is supposed to make it absolutely clear and explicit. There are
other hints as to what a subsequent SOB means in that document already.

Just the next section says:

"The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery
path."

It wouldn't hurt if people would look at that doc from time to time - we
end up referring to it on a daily basis.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
