Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 29 Mar 2018 07:20:27 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 000/109] remove in-kernel calls to syscalls
Message-ID: <20180329142027.GA24860@bombadil.infradead.org>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
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
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, linux-mm@kvack.org, "H . Peter Anvin" <hpa@zytor.com>, tautschn@amazon.co.uk, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, user-mode-linux-devel@lists.sourceforge.net, x86@kernel.org, hmclauchlan@fb.com, Christoph Hellwig <hch@infradead.org>, Jiri Slaby <jslaby@suse.com>, Darren Hart <dvhart@infradead.org>, Jaswinder Singh <jaswinder@infradead.org>, arnd@arndb.de, Jeff Dike <jdike@addtoit.com>, viro@ZenIV.linux.org.uk, Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Luis R . Rodriguez" <mcgrof@kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, "David S . Miller" <davem@davemloft.net>

On Thu, Mar 29, 2018 at 01:22:37PM +0200, Dominik Brodowski wrote:
> At least on 64-bit x86, it will likely be a hard requirement from v4.17
> onwards to not call system call functions in the kernel: It is better to
> use use a different calling convention for system calls there, where 
> struct pt_regs is decoded on-the-fly in a syscall wrapper which then hands
> processing over to the actual syscall function. This means that only those
> parameters which are actually needed for a specific syscall are passed on
> during syscall entry, instead of filling in six CPU registers with random
> user space content all the time (which may cause serious trouble down the
> call chain).[*]

How do we stop new ones from springing up?  Some kind of linker trick
like was used to, er, "dissuade" people from using gets()?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
