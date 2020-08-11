Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot and
 real
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4bbc99b0-3d20-eb22-1996-52474b463fe7@infradead.org>
Date: Mon, 10 Aug 2020 21:56:40 -0700
MIME-Version: 1.0
In-Reply-To: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
Content-Language: en-US
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
To: Orson Zhai <orsonzhai@gmail.com>, Prarit Bhargava <prarit@redhat.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
Cc: zhang.lyra@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ruifeng.zhang1@unisoc.com, Orson Zhai <orson.zhai@unisoc.com>, cixi.geng1@unisoc.com

On 8/10/20 9:40 PM, Orson Zhai wrote:
> +/*
> + * struct timestanps - Simultaneous mono/boot/real timestamps

typo:        timestamps

> + * @mono:	Monotonic timestamp
> + * @boot:	Boottime timestamp
> + * @real:	Realtime timestamp
> + */
> +struct timestamps {
> +	u64		mono;
> +	u64		boot;
> +	u64		real;
> +};


-- 
~Randy


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
