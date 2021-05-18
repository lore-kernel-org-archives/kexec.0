Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 18 May 2021 07:40:29 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
Message-ID: <YKNhXQ883lRbqQGA@infradead.org>
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-2-arnd@kernel.org>
 <m1y2cc3d97.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1y2cc3d97.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org

On Mon, May 17, 2021 at 10:57:24PM -0500, Eric W. Biederman wrote:
> We open ourselves up to bugs whenever we lie to the type system.
> 
> Skimming through the code it looks like it should be possible
> to not need the in_compat_syscall and the casts to the wrong
> type by changing the order of the code a little bit.

What kind of bug do you expect?  We must only copy from user addresses
once anyway.  I've never seen bugs due the use of in_compat_syscall,
but plenty due to cruft code trying to avoid it.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
