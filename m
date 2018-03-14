Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Wed, 14 Mar 2018 18:24:48 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Query] ARM64 kaslr support - randomness, seeding and kdump
Message-ID: <20180314182448.bnvjtgyzipsuxcbe@lakrids.cambridge.arm.com>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
 <20180313102158.GI25863@linaro.org>
 <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
 <20180313110747.GJ25863@linaro.org>
 <20180313112016.ocx4qqhji3zfwjhs@lakrids.cambridge.arm.com>
 <CACi5LpN4DTYFVSVqru2j0y=CKr2ztrJ1gCW32sJBU=oUV2fcWw@mail.gmail.com>
 <20180314021050.GK25863@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180314021050.GK25863@linaro.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh Sharma <bhsharma@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org, Bhupesh SHARMA <bhupesh.linux@gmail.com>

On Wed, Mar 14, 2018 at 11:10:53AM +0900, AKASHI Takahiro wrote:
> If kaslr-seed has a critical value in terms of security, is kexec-tools
> a right place? It is exposed to user space albeit for a short time of period.

The kernel zeroes the seed in the DT at boot time, so the current seed
isn't visible to userspace.

If kexec-tools generates a seed, and inserts it into the DTB that it
loads, this is only visible to kexec tools or other applications which
can inspect its memory, so I don't think this is much of a concern.
Anything with such privilege can presumably kexec() to arbitrary code
anyhow.

The next kernel will then zero its seed in the DT at boot time, so
similarly this won't be visible to userspace on the new kernel.

FWIW, having kexec tools generate a seed for the kexec_load() case makes
sense to me.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
