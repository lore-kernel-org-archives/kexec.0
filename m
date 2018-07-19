Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] arm64, kaslr: export offset in VMCOREINFO ELF notes
References: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <d8959ca1-65a1-f59c-bfc4-b048c75add26@arm.com>
Date: Thu, 19 Jul 2018 12:31:13 +0100
MIME-Version: 1.0
In-Reply-To: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, Catalin Marinas <catalin.marinas@arm.com>, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Bhupesh,

On 18/07/18 22:37, Bhupesh Sharma wrote:
> Include KASLR offset in VMCOREINFO ELF notes to assist in debugging.
> 
> makedumpfile user-space utility will need fixup to use this KASLR offset
> to work with cases where we need to find a way to translate symbol
> address from vmlinux to kernel run time address in case of KASLR boot on
> arm64.

You need the kernel VA for a symbol. Isn't this what kallsyms is for?
| root@frikadeller:~# cat /proc/kallsyms | grep swapper_pg_dir
| ffff5404610d0000 B swapper_pg_dir

This is the KASLR address, the vmlinux has:
| root@frikadeller:~/linux/build_arm64# nm -s vmlinux | grep swapper_pg_dir
| ffff0000096d0000 B swapper_pg_dir


This is in the vmcoreinfo too, so you can work if out from the vmcore too:
| root@frikadeller:~# dd if=/proc/kcore bs=8K count=1 2>/dev/null | strings |
| grep swapper_pg_dir
| SYMBOL(swapper_pg_dir)=ffff5404610d0000


I picked swapper_pg_dir, but you could use any of the vmcore:SYMBOL() addresses
to work out this offset. (you should expect the kernel to rename these symbols
at a whim).


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
