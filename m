Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eMexF-0003sl-3d
 for kexec@lists.infradead.org; Wed, 06 Dec 2017 19:02:03 +0000
Date: Wed, 6 Dec 2017 20:01:24 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v1] kexec-tools: Perform run-time linking of libxenctrl.so
Message-ID: <20171206190124.GI16962@olila.local.net-space.pl>
References: <1511973916-3915-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1511973916-3915-1-git-send-email-eric.devolder@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Wed, Nov 29, 2017 at 10:45:16AM -0600, Eric DeVolder wrote:
> When kexec is utilized in a Xen environment, it has an explicit
> run-time dependency on libxenctrl.so. This dependency occurs
> during the configure stage and when building kexec-tools.
>
> When kexec is utilized in a non-Xen environment (either bare
> metal or KVM), the configure and build of kexec-tools omits
> any reference to libxenctrl.so.
>
> Thus today it is not currently possible to configure and build
> a *single* kexec that will work in *both* Xen and non-Xen
> environments, unless the libxenctrl.so is *always* present.
>
> For example, a kexec configured for Xen in a Xen environment:
>
>  # ldd build/sbin/kexec
>         linux-vdso.so.1 =>  (0x00007ffdeba5c000)
>         libxenctrl.so.4.4 => /usr/lib64/libxenctrl.so.4.4 (0x00000038d8000000)
>         libz.so.1 => /lib64/libz.so.1 (0x00000038d6c00000)
>         libc.so.6 => /lib64/libc.so.6 (0x00000038d6000000)
>         libdl.so.2 => /lib64/libdl.so.2 (0x00000038d6400000)
>         libpthread.so.0 => /lib64/libpthread.so.0 (0x00000038d6800000)
>         /lib64/ld-linux-x86-64.so.2 (0x000055e9f8c6c000)
>  # build/sbin/kexec -v
>  kexec-tools 2.0.16
>
> However, the *same* kexec executable fails in a non-Xen environment:
>
>  # copy xen kexec to .
>  # ldd ./kexec
>          linux-vdso.so.1 =>  (0x00007fffa9da7000)
>          libxenctrl.so.4.4 => not found
>          liblzma.so.0 => /usr/lib64/liblzma.so.0 (0x0000003014e00000)
>          libz.so.1 => /lib64/libz.so.1 (0x000000300ea00000)
>          libc.so.6 => /lib64/libc.so.6 (0x000000300de00000)
>          libpthread.so.0 => /lib64/libpthread.so.0 (0x000000300e200000)
>          /lib64/ld-linux-x86-64.so.2 (0x0000558cc786c000)
>  # ./kexec -v
>  ./kexec: error while loading shared libraries:
>  libxenctrl.so.4.4: cannot open shared object file: No such file or directory
>
> At Oracle we "workaround" this by having two kexec-tools packages,
> one for Xen and another for non-Xen environments. At Oracle, the
> desire is to offer a single kexec-tools package that works in either
> environment. To achieve this, kexec-tools would either have to ship
> with libxenctrl.so (which we have deemed as unacceptable), or we can
> make kexec perform run-time linking against libxenctrl.so.
>
> This patch is one possible way to alleviate the explicit run-time
> dependency on libxenctrl.so. This implementation utilizes a set of
> macros to wrap calls into libxenctrl.so so that the library can
> instead be dlopen() and obtain the function via dlsym() and then
> make the call. The advantage of this implementation is that it
> requires few changes to the existing kexec-tools code. The dis-
> advantage is that it uses macros to remap libxenctrl functions
> and do work under the hood.
>
> Another possible implementation worth considering is the approach
> taken by libvmi. Reference the following file:
>
> https://github.com/libvmi/libvmi/blob/master/libvmi/driver/xen/libxc_wrapper.h
>
> The libxc_wrapper_t structure definition that starts at line ~33
> has members that are function pointers into libxenctrl.so. This
> structure is populated once and then later referenced/dereferenced
> by the callers of libxenctrl.so members. The advantage of this
> implementation is it is more explicit in managing the use of
> libxenctrl.so and its versions, but the disadvantage is it would
> require touching more of the kexec-tools code.

After some thinking it seems to me that we can consider different approach.
Could not we pack all basic Xen libraries into small package called, e.g. libxen?
E.g. Debian provides libxen-4.8 which contains following files:

/usr/lib/x86_64-linux-gnu/libxencall-4.8.so.1
/usr/lib/x86_64-linux-gnu/libxencall-4.8.so.1.0
/usr/lib/x86_64-linux-gnu/libxenctrl-4.8.so
/usr/lib/x86_64-linux-gnu/libxenevtchn-4.8.so.1
/usr/lib/x86_64-linux-gnu/libxenevtchn-4.8.so.1.0
/usr/lib/x86_64-linux-gnu/libxenforeignmemory-4.8.so.1
/usr/lib/x86_64-linux-gnu/libxenforeignmemory-4.8.so.1.0
/usr/lib/x86_64-linux-gnu/libxengnttab-4.8.so.1
/usr/lib/x86_64-linux-gnu/libxengnttab-4.8.so.1.1
/usr/lib/x86_64-linux-gnu/libxenguest-4.8.so
/usr/lib/x86_64-linux-gnu/libxenlight-4.8.so
/usr/lib/x86_64-linux-gnu/libxentoollog-4.8.so.1
/usr/lib/x86_64-linux-gnu/libxentoollog-4.8.so.1.0
/usr/lib/x86_64-linux-gnu/libxlutil-4.8.so
/usr/share/bug/libxen-4.8/control
/usr/share/doc/libxen-4.8/changelog.Debian.gz
/usr/share/doc/libxen-4.8/changelog.gz
/usr/share/doc/libxen-4.8/copyright

Then we do not have to install all other Xen stuff to make kexec-tools happy
on non-Xen machines. And this should also work for other packages requiring
above listed Xen libraries.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
