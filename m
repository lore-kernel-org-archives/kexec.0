Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
Date: Tue, 12 Jul 2016 08:25:48 -0500
In-Reply-To: <20160712014201.11456-1-takahiro.akashi@linaro.org> (AKASHI
 Takahiro's message of "Tue, 12 Jul 2016 10:41:58 +0900")
Message-ID: <87furf7ztv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [RFC 0/3] extend kexec_file_load system call
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: bhe@redhat.com, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, vgoyal@redhat.com

AKASHI Takahiro <takahiro.akashi@linaro.org> writes:

> Device tree blob must be passed to a second kernel on DTB-capable
> archs, like powerpc and arm64, but the current kernel interface
> lacks this support.
>   
> This patch extends kexec_file_load system call by adding an extra
> argument to this syscall so that an arbitrary number of file descriptors
> can be handed out from user space to the kernel.
>
> See the background [1].
>
> Please note that the new interface looks quite similar to the current
> system call, but that it won't always mean that it provides the "binary
> compatibility."
>
> [1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html

So this design is wrong.  The kernel already has the device tree blob,
you should not be extracting it from the kernel munging it, and then
reinserting it in the kernel if you want signatures and everything to
pass.

What x86 does is pass it's equivalent of the device tree blob from one
kernel to another directly and behind the scenes.  It does not go
through userspace for this.

Until a persuasive case can be made for going around the kernel and
probably adding a feature (like code execution) that can be used to
defeat the signature scheme I am going to nack this.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I am happy to see support for other architectures, but for the sake of
not moving some code in the kernel let's not build an attackable
infrastructure.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
