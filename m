Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKfOX-00023D-SF
 for kexec@lists.infradead.org; Fri, 22 Aug 2014 03:20:06 +0000
Date: Fri, 22 Aug 2014 11:19:41 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
Message-ID: <20140822031941.GB2651@dhcp-17-37.nay.redhat.com>
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140821181000.GB21891@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Thomas D." <whissi@whissi.de>, Kexec Mailing List <kexec@lists.infradead.org>, Kees Cook <keescook@chromium.org>

On 08/21/14 at 02:10pm, Vivek Goyal wrote:
>
> If kernel is being moved physically, then we potentially have the issue of
> it stomping other things. So how do we make sure that it does not overwrite
> initramfs, or previous kernel's page tables or something else?

In case you don't read that part, memory of initrd, cmdline and others
won't be overwritten.

This work is done in x86/boot/compressed/aslr.c::mem_avoid_init().

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
