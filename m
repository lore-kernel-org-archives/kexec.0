Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 8 Dec 2020 15:06:14 +0000
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 4/4] compat: remove some compat entry points
Message-ID: <20201208150614.GA15765@infradead.org>
References: <20201102123151.2860165-1-arnd@kernel.org>
 <20201102123151.2860165-5-arnd@kernel.org>
 <20201103083703.GD9092@infradead.org>
 <CAK8P3a2m_VYiTY7Rg+3kfohPc2W=jHLh7dF4aVffSpwMa7C=4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a2m_VYiTY7Rg+3kfohPc2W=jHLh7dF4aVffSpwMa7C=4Q@mail.gmail.com>
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
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Linux-MM <linux-mm@kvack.org>, Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>

On Tue, Nov 03, 2020 at 10:45:54AM +0100, Arnd Bergmann wrote:
> I had it there originally, I guess I should have left it there ;-)
> 
> When I changed it, I was considering to do the same for additional
> syscalls that have very small differences now (timer_create,
> rt_sigqueueinfo, rt_sigpending, recvmsg, sendmsg) and use
> in_compat_syscall() there, but then I decided against that.
> 
> In the end, I did like the split, as I found the smaller three
> patches that contain the real change easier to review, and
> it turns the larger patch at the end into a more obvious
> transformation.

Oh well, let's just keep the split as-is then.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
