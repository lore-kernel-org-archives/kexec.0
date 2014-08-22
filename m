Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKqJg-000692-PF
 for kexec@lists.infradead.org; Fri, 22 Aug 2014 14:59:49 +0000
Date: Fri, 22 Aug 2014 22:59:22 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
Message-ID: <20140822145922.GB1694@dhcp-17-102.nay.redhat.com>
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com>
 <20140822031941.GB2651@dhcp-17-37.nay.redhat.com>
 <20140822123811.GD5954@redhat.com> <53F73BEB.40001@whissi.de>
 <20140822125354.GH5954@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140822125354.GH5954@redhat.com>
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
Cc: "Thomas D." <whissi@whissi.de>, Kexec Mailing List <kexec@lists.infradead.org>, Kees Cook <keescook@chromium.org>, WANG Chao <chaowang@redhat.com>

On 08/22/14 at 08:53am, Vivek Goyal wrote:
> On Fri, Aug 22, 2014 at 02:47:39PM +0200, Thomas D. wrote:
> > On 2014-08-22 14:38, Vivek Goyal wrote:
> > > So may be this failure happens because new kernel stomps over page tables
> > > of old kernel. But if that theory is right, then we should be able to
> > > kexec using 32bit entry point of bzImage.
> > > 
> > > Thomas, have you had any success with that?
> > 
> > When I execute kexec with "--entry-32bit" (I understand that you asked
> > me to try that) the new kernel will boot as expected.
> 
> Good to know that --entry-32bit option makes kexec work with kASLR
> enabled. So this indeed sounds like the issue of page tables being
> stomped over by new kernel.

I don't think page tables could be stomped over by new kernel.
The reason why --entry-32bit can work is kexec-tools get the memory near
the beginning of system RAM. You can check the value passed to argument
buf_end. when --entry-32bit it's 0, that means find memoey hole from low
to high. 

But in 64bit mode, the buf_end is always -1, this cause all memory ready
for kernel/initrd is close to th end of system ram. On my PC with 16G
memory, all those memory around 16G. I changed buf_end to 1, then use
this to load bzImage64, it works too. And addr for
kernel/initrd/real_mode are all allocated from low to high. I don't know
why we need put kernel/initrd/xxx close to the end of system ram.


diff --git a/kexec/add_buffer.c b/kexec/add_buffer.c
index 4d4a55f..ce76669 100644
--- a/kexec/add_buffer.c
+++ b/kexec/add_buffer.c
@@ -10,5 +10,5 @@ unsigned long add_buffer(struct kexec_info *info,
                         int buf_end)
 {
        return add_buffer_virt(info, buf, bufsz, memsz, buf_align,
-                              buf_min, buf_max, buf_end);
+                              buf_min, buf_max, 1);
 }

> 
> IIUC, there are bootloaders which can use 64bit entry point of kernel. I
> think they must run into similar issue too.
> 
> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
