Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hSzGl-0007EU-9e
 for kexec@lists.infradead.org; Tue, 21 May 2019 07:33:26 +0000
Received: from EX13MTAUEB001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (8.14.7/8.14.7) with
 ESMTP id x4L7X23O067187
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <kexec@lists.infradead.org>; Tue, 21 May 2019 07:33:06 GMT
From: Varad Gautam <vrd@amazon.de>
Subject: [PATCH 3/3] x86: Support multiboot2 images
Date: Tue, 21 May 2019 09:32:28 +0200
Message-ID: <1558423948-24583-3-git-send-email-vrd@amazon.de>
In-Reply-To: <1558423948-24583-1-git-send-email-vrd@amazon.de>
References: <1558423948-24583-1-git-send-email-vrd@amazon.de>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: Varad Gautam <vrd@amazon.de>, David Woodhouse <dwmw@amazon.co.uk>

Add a new type `multiboot2-x86` that allows loading multiboot2 images
within the relocation range specified in the image header. The image is
always placed at the lowest available address, regardless of the
preference information.

Also make multiboot2 take priority over multiboot if the -t flag isn't
specified.

Signed-off-by: Varad Gautam <vrd@amazon.de>
---
 doc/multiboot2.html              | 2716 ++++++++++++++++++++++++++++++++++++++
 include/x86/multiboot2.h         |  416 ++++++
 kexec/arch/i386/kexec-mb2-x86.c  |  543 ++++++++
 kexec/arch/i386/kexec-x86.c      |    2 +
 kexec/arch/x86_64/Makefile       |    1 +
 kexec/arch/x86_64/kexec-x86_64.c |    2 +
 kexec/arch/x86_64/kexec-x86_64.h |    5 +
 kexec/kexec.8                    |   24 +
 8 files changed, 3709 insertions(+)
 create mode 100644 doc/multiboot2.html
 create mode 100644 include/x86/multiboot2.h
 create mode 100644 kexec/arch/i386/kexec-mb2-x86.c

diff --git a/doc/multiboot2.html b/doc/multiboot2.html
new file mode 100644
index 0000000..d78f090
--- /dev/null
+++ b/doc/multiboot2.html
@@ -0,0 +1,2716 @@
+<html lang="en">
+<head>
+<title>Multiboot2 Specification version 2.0</title>
+<meta http-equiv="Content-Type" content="text/html">
+<meta name="description" content="Multiboot2 Specification version 2.0">
+<meta name="generator" content="makeinfo 4.13">
+<link title="Top" rel="top" href="#Top">
+<link href="http://www.gnu.org/software/texinfo/" rel="generator-home" title="Texinfo Homepage">
+<!--
+Copyright (C) 1995,96 Bryan Ford <baford@cs.utah.edu>
+
+Copyright (C) 1995,96 Erich Stefan Boleyn <erich@uruk.org>
+
+Copyright (C) 1999,2000,2001,2002,2005,2006,2009,2010,2016 Free Software Foundation, Inc.
+
+     Permission is granted to make and distribute verbatim copies of
+     this manual provided the copyright notice and this permission
+     notice are preserved on all copies.
+
+     Permission is granted to copy and distribute modified versions of
+     this manual under the conditions for verbatim copying, provided
+     also that the entire resulting derived work is distributed under
+     the terms of a permission notice identical to this one.
+
+     Permission is granted to copy and distribute translations of this
+     manual into another language, under the above conditions for
+     modified versions.
+   -->
+<meta http-equiv="Content-Style-Type" content="text/css">
+<style type="text/css"><!--
+  pre.display { font-family:inherit }
+  pre.format  { font-family:inherit }
+  pre.smalldisplay { font-family:inherit; font-size:smaller }
+  pre.smallformat  { font-family:inherit; font-size:smaller }
+  pre.smallexample { font-size:smaller }
+  pre.smalllisp    { font-size:smaller }
+  span.sc    { font-variant:small-caps }
+  span.roman { font-family:serif; font-weight:normal; } 
+  span.sansserif { font-family:sans-serif; font-weight:normal; } 
+--></style>
+</head>
+<body>
+<h1 class="settitle">Multiboot2 Specification version 2.0</h1>
+<div class="node">
+<a name="Top"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Overview">Overview</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#dir">(dir)</a>
+
+</div>
+
+<h2 class="unnumbered">Multiboot2 Specification</h2>
+
+<p>This file documents Multiboot2 Specification, the proposal for the boot
+sequence standard. This edition documents version 2.0.
+
+   <p>Copyright &copy; 1995,96 Bryan Ford &lt;baford@cs.utah.edu&gt;
+
+   <p>Copyright &copy; 1995,96 Erich Stefan Boleyn &lt;erich@uruk.org&gt;
+
+   <p>Copyright &copy; 1999,2000,2001,2002,2005,2006,2009,2010,2016 Free Software Foundation, Inc.
+
+   <blockquote>
+Permission is granted to make and distribute verbatim copies of
+this manual provided the copyright notice and this permission notice
+are preserved on all copies.
+
+   <p>Permission is granted to copy and distribute modified versions of this
+manual under the conditions for verbatim copying, provided also that
+the entire resulting derived work is distributed under the terms of a
+permission notice identical to this one.
+
+   <p>Permission is granted to copy and distribute translations of this manual
+into another language, under the above conditions for modified
+versions. 
+</blockquote>
+
+<ul class="menu">
+<li><a accesskey="1" href="#Overview">Overview</a>
+<li><a accesskey="2" href="#Terminology">Terminology</a>
+<li><a accesskey="3" href="#Specification">Specification</a>
+<li><a accesskey="4" href="#Examples">Examples</a>
+<li><a accesskey="5" href="#History">History</a>
+<li><a accesskey="6" href="#Index">Index</a>
+</ul>
+
+<div class="node">
+<a name="Overview"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Terminology">Terminology</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Top">Top</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>
+
+</div>
+
+<h2 class="chapter">1 Introduction to Multiboot2 Specification</h2>
+
+<p>This chapter describes some rough information on the Multiboot2
+Specification. Note that this is not a part of the specification itself.
+
+<ul class="menu">
+<li><a accesskey="1" href="#Motivation">Motivation</a>
+<li><a accesskey="2" href="#Architecture">Architecture</a>
+<li><a accesskey="3" href="#Operating-systems">Operating systems</a>
+<li><a accesskey="4" href="#Boot-sources">Boot sources</a>
+<li><a accesskey="5" href="#Boot_002dtime-configuration">Boot-time configuration</a>
+<li><a accesskey="6" href="#Convenience-to-operating-systems">Convenience to operating systems</a>
+<li><a accesskey="7" href="#Boot-modules">Boot modules</a>
+</ul>
+
+<div class="node">
+<a name="Motivation"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Architecture">Architecture</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Overview">Overview</a>
+
+</div>
+
+<h3 class="section">1.1 The background of Multiboot2 Specification</h3>
+
+<p>Every operating system ever created tends to have its own boot loader. 
+Installing a new operating system on a machine generally involves
+installing a whole new set of boot mechanisms, each with completely
+different install-time and boot-time user interfaces. Getting multiple
+operating systems to coexist reliably on one machine through typical
+<dfn>chaining</dfn> mechanisms can be a nightmare. There is little or no
+choice of boot loaders for a particular operating system &mdash; if the one
+that comes with the operating system doesn't do exactly what you want,
+or doesn't work on your machine, you're screwed.
+
+   <p>While we may not be able to fix this problem in existing proprietary
+operating systems, it shouldn't be too difficult for a few people in the
+free operating system communities to put their heads together and solve
+this problem for the popular free operating systems. That's what this
+specification aims for. Basically, it specifies an interface between a
+boot loader and a operating system, such that any complying boot loader
+should be able to load any complying operating system. This
+specification does <em>not</em> specify how boot loaders should work &mdash;
+only how they must interface with the operating system being loaded.
+
+<div class="node">
+<a name="Architecture"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Operating-systems">Operating systems</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Motivation">Motivation</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Overview">Overview</a>
+
+</div>
+
+<h3 class="section">1.2 The target architecture</h3>
+
+<p>This specification is primarily targeted at <span class="sc">pc</span>, since they are the
+most common and have the largest variety of operating systems and boot
+loaders. However, to the extent that certain other architectures may
+need a boot specification and do not have one already, a variation of
+this specification, stripped of the x86-specific details, could be
+adopted for them as well.
+
+<div class="node">
+<a name="Operating-systems"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Boot-sources">Boot sources</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Architecture">Architecture</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Overview">Overview</a>
+
+</div>
+
+<h3 class="section">1.3 The target operating systems</h3>
+
+<p>This specification is targeted toward free 32-bit operating systems
+that can be fairly easily modified to support the specification without
+going through lots of bureaucratic rigmarole. The particular free
+operating systems that this specification is being primarily designed
+for are Linux, the kernels of FreeBSD and NetBSD, Mach, and VSTa. It is hoped that other
+emerging free operating systems will adopt it from the start, and thus
+immediately be able to take advantage of existing boot loaders. It would
+be nice if proprietary operating system vendors eventually adopted this
+specification as well, but that's probably a pipe dream.
+
+<div class="node">
+<a name="Boot-sources"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Boot_002dtime-configuration">Boot-time configuration</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Operating-systems">Operating systems</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Overview">Overview</a>
+
+</div>
+
+<h3 class="section">1.4 Boot sources</h3>
+
+<p>It should be possible to write compliant boot loaders that load the OS
+image from a variety of sources, including floppy disk, hard disk, and
+across a network.
+
+   <p>Disk-based boot loaders may use a variety of techniques to find the
+relevant OS image and boot module data on disk, such as by
+interpretation of specific file systems (e.g. the BSD/Mach boot loader),
+using precalculated <dfn>blocklists</dfn> (e.g. LILO), loading from a
+special <dfn>boot partition</dfn> (e.g. OS/2), or even loading from within
+another operating system (e.g. the VSTa boot code, which loads from
+DOS). Similarly, network-based boot loaders could use a variety of
+network hardware and protocols.
+
+   <p>It is hoped that boot loaders will be created that support multiple
+loading mechanisms, increasing their portability, robustness, and
+user-friendliness.
+
+<div class="node">
+<a name="Boot-time-configuration"></a>
+<a name="Boot_002dtime-configuration"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Convenience-to-operating-systems">Convenience to operating systems</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Boot-sources">Boot sources</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Overview">Overview</a>
+
+</div>
+
+<h3 class="section">1.5 Configure an operating system at boot-time</h3>
+
+<p>It is often necessary for one reason or another for the user to be able
+to provide some configuration information to an operating system
+dynamically at boot time. While this specification should not dictate
+how this configuration information is obtained by the boot loader, it
+should provide a standard means for the boot loader to pass such
+information to the operating system.
+
+<div class="node">
+<a name="Convenience-to-operating-systems"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Boot-modules">Boot modules</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Boot_002dtime-configuration">Boot-time configuration</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Overview">Overview</a>
+
+</div>
+
+<h3 class="section">1.6 How to make OS development easier</h3>
+
+<p>OS images should be easy to generate. Ideally, an OS image should simply
+be an ordinary 32-bit executable file in whatever file format the
+operating system normally uses. It should be possible to <code>nm</code> or
+disassemble OS images just like normal executables. Specialized tools
+should not be required to create OS images in a <em>special</em> file
+format. If this means shifting some work from the operating system to
+a boot loader, that is probably appropriate, because all the memory
+consumed by the boot loader will typically be made available again after
+the boot process is created, whereas every bit of code in the OS image
+typically has to remain in memory forever. The operating system should
+not have to worry about getting into 32-bit mode initially, because mode
+switching code generally needs to be in the boot loader anyway in order
+to load operating system data above the 1MB boundary, and forcing the
+operating system to do this makes creation of OS images much more
+difficult.
+
+   <p>Unfortunately, there is a horrendous variety of executable file formats
+even among free Unix-like <span class="sc">pc</span>-based operating systems &mdash; generally
+a different format for each operating system. Most of the relevant free
+operating systems use some variant of a.out format, but some are moving
+to <span class="sc">elf</span>. It is highly desirable for boot loaders not to have to be
+able to interpret all the different types of executable file formats in
+existence in order to load the OS image &mdash; otherwise the boot loader
+effectively becomes operating system specific again.
+
+   <p>This specification adopts a compromise solution to this
+problem. Multiboot2-compliant OS images always contain a magic
+<dfn>Multiboot2 header</dfn> (see <a href="#OS-image-format">OS image format</a>), which allows the boot
+loader to load the image without having to understand numerous a.out
+variants or other executable formats. This magic header does not need to
+be at the very beginning of the executable file, so kernel images can
+still conform to the local a.out format variant in addition to being
+Multiboot2-compliant.
+
+<div class="node">
+<a name="Boot-modules"></a>
+<p><hr>
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Convenience-to-operating-systems">Convenience to operating systems</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Overview">Overview</a>
+
+</div>
+
+<h3 class="section">1.7 Boot modules</h3>
+
+<p>Many modern operating system kernels, such as Mach and the microkernel in VSTa, do
+not by themselves contain enough mechanism to get the system fully
+operational: they require the presence of additional software modules at
+boot time in order to access devices, mount file systems, etc. While
+these additional modules could be embedded in the main OS image along
+with the kernel itself, and the resulting image be split apart manually
+by the operating system when it receives control, it is often more
+flexible, more space-efficient, and more convenient to the operating
+system and user if the boot loader can load these additional modules
+independently in the first place.
+
+   <p>Thus, this specification should provide a standard method for a boot
+loader to indicate to the operating system what auxiliary boot modules
+were loaded, and where they can be found. Boot loaders don't have to
+support multiple boot modules, but they are strongly encouraged to,
+because some operating systems will be unable to boot without them.
+
+<div class="node">
+<a name="Terminology"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Specification">Specification</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Overview">Overview</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>
+
+</div>
+
+<h2 class="chapter">2 The definitions of terms used through the specification</h2>
+
+     <dl>
+<dt><dfn>must</dfn><dd>We use the term <dfn>must</dfn>, when any boot loader or OS image needs to
+follow a rule &mdash; otherwise, the boot loader or OS image is <em>not</em>
+Multiboot2-compliant.
+
+     <br><dt><dfn>should</dfn><dd>We use the term <dfn>should</dfn>, when any boot loader or OS image is
+recommended to follow a rule, but it doesn't need to follow the rule.
+
+     <br><dt><dfn>may</dfn><dd>We use the term <dfn>may</dfn>, when any boot loader or OS image is allowed
+to follow a rule.
+
+     <br><dt><dfn>boot loader</dfn><dd>Whatever program or set of programs loads the image of the final
+operating system to be run on the machine. The boot loader may itself
+consist of several stages, but that is an implementation detail not
+relevant to this specification. Only the <em>final</em> stage of the boot
+loader &mdash; the stage that eventually transfers control to an operating
+system &mdash; must follow the rules specified in this document in order
+to be <dfn>Multiboot2-compliant</dfn>; earlier boot loader stages may be
+designed in whatever way is most convenient.
+
+     <br><dt><dfn>OS image, kernel</dfn><dd>The initial binary image that a boot loader loads into memory and
+transfers control to start an operating system. The OS image is
+typically an executable containing the operating system kernel. 
+However it doesn't need to be a part of any OS and may be any kind
+of system tool.
+
+     <br><dt><dfn>boot module</dfn><dd>Other auxiliary files that a boot loader loads into memory along with
+an OS image, but does not interpret in any way other than passing their
+locations to the operating system when it is invoked.
+
+     <br><dt><dfn>Multiboot2-compliant</dfn><dd>A boot loader or an OS image which follows the rules defined as
+<dfn>must</dfn> is Multiboot2-compliant. When this specification specifies a
+rule as <dfn>should</dfn> or <dfn>may</dfn>, a Multiboot2-complaint boot loader/OS
+image doesn't need to follow the rule.
+
+     <br><dt><dfn>u8</dfn><dd>The type of unsigned 8-bit data.
+
+     <br><dt><dfn>u16</dfn><dd>The type of unsigned 16-bit data. Because the target architecture is
+little-endian, u16 is coded in little-endian.
+
+     <br><dt><dfn>u32</dfn><dd>The type of unsigned 32-bit data. Because the target architecture is
+little-endian, u32 is coded in little-endian.
+
+     <br><dt><dfn>u64</dfn><dd>The type of unsigned 64-bit data. Because the target architecture is
+little-endian, u64 is coded in little-endian.
+
+</dl>
+
+<div class="node">
+<a name="Specification"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Examples">Examples</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Terminology">Terminology</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>
+
+</div>
+
+<h2 class="chapter">3 The exact definitions of Multiboot2 Specification</h2>
+
+<p>There are three main aspects of a boot loader/OS image interface:
+
+     <ol type=1 start=1>
+<li>The format of an OS image as seen by a boot loader.
+
+     <li>The state of a machine when a boot loader starts an operating
+system.
+
+     <li>The format of information passed by a boot loader to an operating
+system.
+        </ol>
+
+<ul class="menu">
+<li><a accesskey="1" href="#OS-image-format">OS image format</a>
+<li><a accesskey="2" href="#Machine-state">Machine state</a>
+<li><a accesskey="3" href="#Boot-information-format">Boot information format</a>
+</ul>
+
+<div class="node">
+<a name="OS-image-format"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Machine-state">Machine state</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Specification">Specification</a>
+
+</div>
+
+<h3 class="section">3.1 OS image format</h3>
+
+<p>An OS image may be an ordinary 32-bit executable file in the standard
+format for that particular operating system, except that it may be
+linked at a non-default load address to avoid loading on top of the
+<span class="sc">pc</span>'s I/O region or other reserved areas, and of course it should
+not use shared libraries or other fancy features.
+
+   <p>An OS image must contain an additional header called <dfn>Multiboot2
+header</dfn>, besides the headers of the format used by the OS image. The
+Multiboot2 header must be contained completely within the first 32768
+bytes of the OS image, and must be 64-bit aligned. In
+general, it should come <em>as early as possible</em>, and may be
+embedded in the beginning of the text segment after the <em>real</em>
+executable header.
+
+<ul class="menu">
+<li><a accesskey="1" href="#Header-layout">Header layout</a>:                The layout of Multiboot2 header
+<li><a accesskey="2" href="#Header-magic-fields">Header magic fields</a>:          The magic fields of Multiboot2 header
+<li><a accesskey="3" href="#Header-tags">Header tags</a>
+<li><a accesskey="4" href="#Information-request-header-tag">Information request header tag</a>
+<li><a accesskey="5" href="#Address-header-tag">Address header tag</a>
+<li><a accesskey="6" href="#Console-header-tags">Console header tags</a>
+<li><a accesskey="7" href="#Module-alignment-tag">Module alignment tag</a>
+<li><a accesskey="8" href="#EFI-boot-services-tag">EFI boot services tag</a>
+<li><a accesskey="9" href="#Relocatable-header-tag">Relocatable header tag</a>
+
+   </ul>
+
+<div class="node">
+<a name="Header-layout"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Header-magic-fields">Header magic fields</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#OS-image-format">OS image format</a>
+
+</div>
+
+<h4 class="subsection">3.1.1 The layout of Multiboot2 header</h4>
+
+<p>The layout of the Multiboot2 header must be as follows:
+
+   <p><table summary=""><tr align="left"><td valign="top" width="10%">Offset </td><td valign="top" width="10%">Type  </td><td valign="top" width="20%">Field Name   </td><td valign="top" width="50%">Note
+<br></td></tr><tr align="left"><td valign="top" width="10%">0      </td><td valign="top" width="10%">u32 </td><td valign="top" width="20%">magic          </td><td valign="top" width="50%">required
+<br></td></tr><tr align="left"><td valign="top" width="10%">4      </td><td valign="top" width="10%">u32 </td><td valign="top" width="20%">architecture   </td><td valign="top" width="50%">required
+<br></td></tr><tr align="left"><td valign="top" width="10%">8      </td><td valign="top" width="10%">u32 </td><td valign="top" width="20%">header_length  </td><td valign="top" width="50%">required
+<br></td></tr><tr align="left"><td valign="top" width="10%">12     </td><td valign="top" width="10%">u32 </td><td valign="top" width="20%">checksum       </td><td valign="top" width="50%">required
+<br></td></tr><tr align="left"><td valign="top" width="10%">16-XX  </td><td valign="top" width="10%"></td><td valign="top" width="20%">tags           </td><td valign="top" width="50%">required
+   <br></td></tr></table>
+
+   <p>The fields &lsquo;<samp><span class="samp">magic</span></samp>&rsquo;, &lsquo;<samp><span class="samp">architecture</span></samp>&rsquo;, &lsquo;<samp><span class="samp">header_length</span></samp>&rsquo; and &lsquo;<samp><span class="samp">checksum</span></samp>&rsquo; are defined in <a href="#Header-magic-fields">Header magic fields</a>, &lsquo;<samp><span class="samp">tags</span></samp>&rsquo;
+are defined in <a href="#Header-tags">Header tags</a>. All fields are in native endianness. 
+On bi-endian platforms native-endianness means the endiannes OS image starts in.
+
+<div class="node">
+<a name="Header-magic-fields"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Header-tags">Header tags</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Header-layout">Header layout</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#OS-image-format">OS image format</a>
+
+</div>
+
+<h4 class="subsection">3.1.2 The magic fields of Multiboot2 header</h4>
+
+     <dl>
+<dt>&lsquo;<samp><span class="samp">magic</span></samp>&rsquo;<dd>The field &lsquo;<samp><span class="samp">magic</span></samp>&rsquo; is the magic number identifying the header,
+which must be the hexadecimal value <code>0xE85250D6</code>.
+
+     <br><dt>&lsquo;<samp><span class="samp">architecture</span></samp>&rsquo;<dd>The field &lsquo;<samp><span class="samp">architecture</span></samp>&rsquo; specifies the Central Processing Unit
+Instruction Set Architecture. Since &lsquo;<samp><span class="samp">magic</span></samp>&rsquo; isn't a palindrome
+it already specifies the endianness ISAs differing only in endianness
+recieve the same ID. &lsquo;<samp><span class="samp">0</span></samp>&rsquo; means 32-bit (protected) mode of i386. 
+&lsquo;<samp><span class="samp">4</span></samp>&rsquo; means 32-bit MIPS.
+
+     <br><dt>&lsquo;<samp><span class="samp">header_length</span></samp>&rsquo;<dd>The field &lsquo;<samp><span class="samp">header_length</span></samp>&rsquo; specifies the Length of Multiboot2 header
+in bytes including magic fields.
+
+     <br><dt>&lsquo;<samp><span class="samp">checksum</span></samp>&rsquo;<dd>The field &lsquo;<samp><span class="samp">checksum</span></samp>&rsquo; is a 32-bit unsigned value which, when added
+to the other magic fields (i.e. &lsquo;<samp><span class="samp">magic</span></samp>&rsquo;, &lsquo;<samp><span class="samp">architecture</span></samp>&rsquo;
+and &lsquo;<samp><span class="samp">header_length</span></samp>&rsquo;), must have a 32-bit unsigned sum of zero. 
+</dl>
+
+<div class="node">
+<a name="Header-tags"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Information-request-header-tag">Information request header tag</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Header-magic-fields">Header magic fields</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#OS-image-format">OS image format</a>
+
+</div>
+
+<h4 class="subsection">3.1.3 General tag structure</h4>
+
+<p>Tags constitutes a buffer of structures following each other padded when necessary
+in order for each tag to start at 8-bytes aligned address. Tags are terminated by
+a tag of type &lsquo;<samp><span class="samp">0</span></samp>&rsquo; and size &lsquo;<samp><span class="samp">8</span></samp>&rsquo;. Every structure has following format:
+
+<pre class="example">             +-------------------+
+     u16     | type              |
+     u16     | flags             |
+     u32     | size              |
+             +-------------------+
+</pre>
+   <p>&lsquo;<samp><span class="samp">type</span></samp>&rsquo; is divided into 2 parts. Lower contains an identifier of contents of the rest of the tag. 
+&lsquo;<samp><span class="samp">size</span></samp>&rsquo; contains the size of tag including header fields. 
+If bit &lsquo;<samp><span class="samp">0</span></samp>&rsquo; of &lsquo;<samp><span class="samp">flags</span></samp>&rsquo; (also known as &lsquo;<samp><span class="samp">optional</span></samp>&rsquo;) is set, the bootloader may ignore this tag if it
+lacks relevant support. 
+Tags are terminated by a tag of type &lsquo;<samp><span class="samp">0</span></samp>&rsquo; and size &lsquo;<samp><span class="samp">8</span></samp>&rsquo;.
+
+<div class="node">
+<a name="Information-request-header-tag"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Address-header-tag">Address header tag</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Header-tags">Header tags</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#OS-image-format">OS image format</a>
+
+</div>
+
+<h4 class="subsection">3.1.4 Multiboot2 information request</h4>
+
+<pre class="example">             +-------------------+
+     u16     | type = 1          |
+     u16     | flags             |
+     u32     | size              |
+     u32[n]  | mbi_tag_types     |
+             +-------------------+
+</pre>
+   <p>&lsquo;<samp><span class="samp">mbi_tag_types</span></samp>&rsquo; is an array of u32's, each one representing an information request.
+
+   <p>If this tag is present and &lsquo;<samp><span class="samp">optional</span></samp>&rsquo; is set to &lsquo;<samp><span class="samp">0</span></samp>&rsquo;, the bootloader must
+support the requested tag and be able to provide relevant information to the image
+if it is available. If the bootloader does not understand the meaning of the requested
+tag it must fail with an error. However, if it supports a given tag but the information
+conveyed by it is not available the bootloader does not provide the requested tag in
+the Multiboot2 information structure and passes control to the loaded image as usual.
+
+   <p>Note: The above means that there is no guarantee that any tags of type &lsquo;<samp><span class="samp">mbi_tag_types</span></samp>&rsquo;
+will actually be present. E.g. on a videoless system even if you requested tag &lsquo;<samp><span class="samp">8</span></samp>&rsquo;
+and the bootloader supports it, no tags of type &lsquo;<samp><span class="samp">8</span></samp>&rsquo; will be present in the Multiboot2
+information structure.
+
+<div class="node">
+<a name="Address-header-tag"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Console-header-tags">Console header tags</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Information-request-header-tag">Information request header tag</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#OS-image-format">OS image format</a>
+
+</div>
+
+<h4 class="subsection">3.1.5 The address tag of Multiboot2 header</h4>
+
+<pre class="example">             +-------------------+
+     u16     | type = 2          |
+     u16     | flags             |
+     u32     | size              |
+     u32     | header_addr       |
+     u32     | load_addr         |
+     u32     | load_end_addr     |
+     u32     | bss_end_addr      |
+             +-------------------+
+</pre>
+   <p>All of the address fields in this tag are physical addresses. 
+The meaning of each is as follows:
+
+     <dl>
+<dt><code>header_addr</code><dd>Contains the address corresponding to the beginning of the Multiboot2
+header &mdash; the physical memory location at which the magic value is
+supposed to be loaded. This field serves to <dfn>synchronize</dfn> the
+mapping between OS image offsets and physical memory addresses.
+
+     <br><dt><code>load_addr</code><dd>Contains the physical address of the beginning of the text segment. The
+offset in the OS image file at which to start loading is defined by the
+offset at which the header was found, minus (header_addr -
+load_addr). load_addr must be less than or equal to header_addr.
+
+     <p>Special value -1 means that the file must be loaded from its beginning.
+
+     <br><dt><code>load_end_addr</code><dd>Contains the physical address of the end of the data
+segment. (load_end_addr - load_addr) specifies how much data to load. 
+This implies that the text and data segments must be consecutive in the
+OS image; this is true for existing a.out executable formats. 
+If this field is zero, the boot loader assumes that the text and data
+segments occupy the whole OS image file.
+
+     <br><dt><code>bss_end_addr</code><dd>Contains the physical address of the end of the bss segment. The boot
+loader initializes this area to zero, and reserves the memory it
+occupies to avoid placing boot modules and other data relevant to the
+operating system in that area. If this field is zero, the boot loader
+assumes that no bss segment is present.
+
+   </dl>
+
+<h4 class="subsection">3.1.6 The entry address tag of Multiboot2 header</h4>
+
+<pre class="example">             +-------------------+
+     u16     | type = 3          |
+     u16     | flags             |
+     u32     | size              |
+     u32     | entry_addr        |
+             +-------------------+
+</pre>
+   <p>All of the address fields in this tag are physical addresses. 
+The meaning of each is as follows:
+
+     <dl>
+<dt><code>entry_addr</code><dd>The physical address to which the boot loader should jump in order to
+start running the operating system. 
+</dl>
+
+<h4 class="subsection">3.1.7 EFI i386 entry address tag of Multiboot2 header</h4>
+
+<pre class="example">             +-------------------+
+     u16     | type = 8          |
+     u16     | flags             |
+     u32     | size              |
+     u32     | entry_addr        |
+             +-------------------+
+</pre>
+   <p>All of the address fields in this tag are physical addresses. 
+The meaning of each is as follows:
+
+     <dl>
+<dt><code>entry_addr</code><dd>The physical address to which the boot loader should jump in order to
+start running EFI i386 compatible operating system code. 
+</dl>
+
+   <p>This tag is taken into account only on EFI i386 platforms
+when Multiboot2 image header contains EFI boot services tag. 
+Then entry point specified in ELF header and the entry address
+tag of Multiboot2 header are ignored.
+
+<h4 class="subsection">3.1.8 EFI amd64 entry address tag of Multiboot2 header</h4>
+
+<pre class="example">             +-------------------+
+     u16     | type = 9          |
+     u16     | flags             |
+     u32     | size              |
+     u32     | entry_addr        |
+             +-------------------+
+</pre>
+   <p>All of the address fields in this tag are physical addresses (paging
+mode is enabled and any memory space defined by the UEFI memory map
+is identity mapped, hence, virtual address equals physical address;
+Unified Extensible Firmware Interface Specification, Version 2.6,
+section 2.3.4, x64 Platforms, boot services). The meaning of each
+is as follows:
+
+     <dl>
+<dt><code>entry_addr</code><dd>The physical address to which the boot loader should jump in order to
+start running EFI amd64 compatible operating system code. 
+</dl>
+
+   <p>This tag is taken into account only on EFI amd64 platforms
+when Multiboot2 image header contains EFI boot services tag. 
+Then entry point specified in ELF header and the entry address
+tag of Multiboot2 header are ignored.
+
+<div class="node">
+<a name="Console-header-tags"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Module-alignment-tag">Module alignment tag</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Address-header-tag">Address header tag</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#OS-image-format">OS image format</a>
+
+</div>
+
+<h4 class="subsection">3.1.9 Flags tag</h4>
+
+<pre class="example">             +-------------------+
+     u16     | type = 4          |
+     u16     | flags             |
+     u32     | size = 12         |
+     u32     | console_flags     |
+             +-------------------+
+</pre>
+   <p>If this tag is present and bit 0 of &lsquo;<samp><span class="samp">console_flags</span></samp>&rsquo; is set
+at least one of supported consoles must be present and information about it must be available in mbi. 
+If bit &lsquo;<samp><span class="samp">1</span></samp>&rsquo; of &lsquo;<samp><span class="samp">console_flags</span></samp>&rsquo; is set it
+indicates that the OS image has EGA text support.
+
+<h4 class="subsection">3.1.10 The framebuffer tag of Multiboot2 header</h4>
+
+<pre class="example">             +-------------------+
+     u16     | type = 5          |
+     u16     | flags             |
+     u32     | size = 20         |
+     u32     | width             |
+     u32     | height            |
+     u32     | depth             |
+             +-------------------+
+</pre>
+   <p>This tag specifies the preferred graphics mode. If this tag is present
+bootloader assumes that the payload has framebuffer support. 
+Note that that is only a <em>recommended</em>
+mode by the OS image. Boot loader may choose a different mode if it sees fit.
+
+   <p>The meaning of each is as follows:
+
+     <dl>
+<dt><code>width</code><dd>Contains the number of the columns. This is specified in pixels in a
+graphics mode, and in characters in a text mode. The value zero
+indicates that the OS image has no preference.
+
+     <br><dt><code>height</code><dd>Contains the number of the lines. This is specified in pixels in a
+graphics mode, and in characters in a text mode. The value zero
+indicates that the OS image has no preference.
+
+     <br><dt><code>depth</code><dd>Contains the number of bits per pixel in a graphics mode, and zero in
+a text mode. The value zero indicates that the OS image has no
+preference. 
+</dl>
+
+<div class="node">
+<a name="Module-alignment-tag"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#EFI-boot-services-tag">EFI boot services tag</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Console-header-tags">Console header tags</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#OS-image-format">OS image format</a>
+
+</div>
+
+<h4 class="subsection">3.1.11 Module alignment tag</h4>
+
+<pre class="example">             +-------------------+
+     u16     | type = 6          |
+     u16     | flags             |
+     u32     | size = 8          |
+             +-------------------+
+</pre>
+   <p>If this tag is present modules must be page aligned.
+
+<div class="node">
+<a name="EFI-boot-services-tag"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Relocatable-header-tag">Relocatable header tag</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Module-alignment-tag">Module alignment tag</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#OS-image-format">OS image format</a>
+
+</div>
+
+<h4 class="subsection">3.1.12 EFI boot services tag</h4>
+
+<pre class="example">             +-------------------+
+     u16     | type = 7          |
+     u16     | flags             |
+     u32     | size = 8          |
+             +-------------------+
+</pre>
+   <p>This tag indicates that payload supports starting without
+terminating boot services.
+
+<div class="node">
+<a name="Relocatable-header-tag"></a>
+<p><hr>
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#EFI-boot-services-tag">EFI boot services tag</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#OS-image-format">OS image format</a>
+
+</div>
+
+<h4 class="subsection">3.1.13 Relocatable header tag</h4>
+
+<pre class="example">             +-------------------+
+     u16     | type = 10         |
+     u16     | flags             |
+     u32     | size = 24         |
+     u32     | min_addr          |
+     u32     | max_addr          |
+     u32     | align             |
+     u32     | preference        |
+             +-------------------+
+</pre>
+   <p>This tag indicates that image is relocatable.
+
+   <p>The meaning of each field is as follows:
+
+     <dl>
+<dt><code>min_addr</code><dd>Lowest possible physical address at which image should be loaded. 
+The bootloader cannot load any part of image below this address.
+
+     <br><dt><code>max_addr</code><dd>Highest possible physical address at which loaded image should end. 
+The bootloader cannot load any part of image above this address.
+
+     <br><dt><code>align</code><dd>Image alignment in memory, e.g. 4096.
+
+     <br><dt><code>preference</code><dd>It contains load address placement suggestion for boot loader. 
+Boot loader should follow it. &lsquo;<samp><span class="samp">0</span></samp>&rsquo; means none, &lsquo;<samp><span class="samp">1</span></samp>&rsquo; means
+load image at lowest possible address but not lower than min_addr
+and &lsquo;<samp><span class="samp">2</span></samp>&rsquo; means load image at highest possible address but not
+higher than max_addr. 
+</dl>
+
+<div class="node">
+<a name="Machine-state"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Boot-information-format">Boot information format</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#OS-image-format">OS image format</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Specification">Specification</a>
+
+</div>
+
+<h3 class="section">3.2 MIPS machine state</h3>
+
+<p>When the boot loader invokes the operating system, the machine
+must have the following state:
+
+     <dl>
+<dt>&lsquo;<samp><span class="samp">R4 (also known as A0)</span></samp>&rsquo;<dd>Must contain the magic value &lsquo;<samp><span class="samp">0x36d76289</span></samp>&rsquo;; the presence of this
+value indicates to the operating system that it was loaded by a
+Multiboot2-compliant boot loader (e.g. as opposed to another type of
+boot loader that the operating system can also be loaded from).
+
+     <br><dt>&lsquo;<samp><span class="samp">R5 (also known as A1)</span></samp>&rsquo;<dd>Must contain the 32-bit physical address of the Multiboot2
+information structure provided by the boot loader (see <a href="#Boot-information-format">Boot information format</a>). 
+</dl>
+
+   <p>All other processor registers and flag bits are undefined. This
+includes, in particular:
+
+     <dl>
+<dt>&lsquo;<samp><span class="samp">R29/SP</span></samp>&rsquo;<dd>The OS image must create its own stack as soon as it needs one.
+
+   </dl>
+
+<h3 class="section">3.3 I386 machine state</h3>
+
+<p>When the boot loader invokes the 32-bit operating system, the machine
+must have the following state:
+
+     <dl>
+<dt>&lsquo;<samp><span class="samp">EAX</span></samp>&rsquo;<dd>Must contain the magic value &lsquo;<samp><span class="samp">0x36d76289</span></samp>&rsquo;; the presence of this
+value indicates to the operating system that it was loaded by a
+Multiboot2-compliant boot loader (e.g. as opposed to another type of
+boot loader that the operating system can also be loaded from).
+
+     <br><dt>&lsquo;<samp><span class="samp">EBX</span></samp>&rsquo;<dd>Must contain the 32-bit physical address of the Multiboot2
+information structure provided by the boot loader (see <a href="#Boot-information-format">Boot information format</a>).
+
+     <br><dt>&lsquo;<samp><span class="samp">CS</span></samp>&rsquo;<dd>Must be a 32-bit read/execute code segment with an offset of &lsquo;<samp><span class="samp">0</span></samp>&rsquo;
+and a limit of &lsquo;<samp><span class="samp">0xFFFFFFFF</span></samp>&rsquo;. The exact value is undefined.
+
+     <br><dt>&lsquo;<samp><span class="samp">DS</span></samp>&rsquo;<dt>&lsquo;<samp><span class="samp">ES</span></samp>&rsquo;<dt>&lsquo;<samp><span class="samp">FS</span></samp>&rsquo;<dt>&lsquo;<samp><span class="samp">GS</span></samp>&rsquo;<dt>&lsquo;<samp><span class="samp">SS</span></samp>&rsquo;<dd>Must be a 32-bit read/write data segment with an offset of &lsquo;<samp><span class="samp">0</span></samp>&rsquo;
+and a limit of &lsquo;<samp><span class="samp">0xFFFFFFFF</span></samp>&rsquo;. The exact values are all undefined.
+
+     <br><dt>&lsquo;<samp><span class="samp">A20 gate</span></samp>&rsquo;<dd>Must be enabled.
+
+     <br><dt>&lsquo;<samp><span class="samp">CR0</span></samp>&rsquo;<dd>Bit 31 (PG) must be cleared. Bit 0 (PE) must be set. Other bits are
+all undefined.
+
+     <br><dt>&lsquo;<samp><span class="samp">EFLAGS</span></samp>&rsquo;<dd>Bit 17 (VM) must be cleared. Bit 9 (IF) must be cleared. Other bits
+are all undefined. 
+</dl>
+
+   <p>All other processor registers and flag bits are undefined. This
+includes, in particular:
+
+     <dl>
+<dt>&lsquo;<samp><span class="samp">ESP</span></samp>&rsquo;<dd>The OS image must create its own stack as soon as it needs one.
+
+     <br><dt>&lsquo;<samp><span class="samp">GDTR</span></samp>&rsquo;<dd>Even though the segment registers are set up as described above, the
+&lsquo;<samp><span class="samp">GDTR</span></samp>&rsquo; may be invalid, so the OS image must not load any segment
+registers (even just reloading the same values!) until it sets up its
+own &lsquo;<samp><span class="samp">GDT</span></samp>&rsquo;.
+
+     <br><dt>&lsquo;<samp><span class="samp">IDTR</span></samp>&rsquo;<dd>The OS image must leave interrupts disabled until it sets up its own
+<code>IDT</code>. 
+</dl>
+
+   <p>On EFI system boot services must be terminated.
+
+<h3 class="section">3.4 EFI i386 machine state with boot services enabled</h3>
+
+<p>When the boot loader invokes the 32-bit operating system on EFI i386
+platform and EFI boot services tag together with EFI i386 entry address
+tag are present in the image Multiboot2 header, the machine must have the
+following state:
+
+     <dl>
+<dt>&lsquo;<samp><span class="samp">EAX</span></samp>&rsquo;<dd>Must contain the magic value &lsquo;<samp><span class="samp">0x36d76289</span></samp>&rsquo;; the presence of this
+value indicates to the operating system that it was loaded by a
+Multiboot2-compliant boot loader (e.g. as opposed to another type of
+boot loader that the operating system can also be loaded from).
+
+     <br><dt>&lsquo;<samp><span class="samp">EBX</span></samp>&rsquo;<dd>Must contain the 32-bit physical address of the Multiboot2
+information structure provided by the boot loader (see <a href="#Boot-information-format">Boot information format</a>). 
+</dl>
+
+   <p>All other processor registers, flag bits and state are set accordingly
+to Unified Extensible Firmware Interface Specification, Version 2.6,
+section 2.3.2, IA-32 Platforms, boot services.
+
+<h3 class="section">3.5 EFI amd64 machine state with boot services enabled</h3>
+
+<p>When the boot loader invokes the 64-bit operating system on EFI amd64
+platform and EFI boot services tag together with EFI amd64 entry address
+tag are present in the image Multiboot2 header, the machine must have the
+following state:
+
+     <dl>
+<dt>&lsquo;<samp><span class="samp">EAX</span></samp>&rsquo;<dd>Must contain the magic value &lsquo;<samp><span class="samp">0x36d76289</span></samp>&rsquo;; the presence of this
+value indicates to the operating system that it was loaded by a
+Multiboot2-compliant boot loader (e.g. as opposed to another type of
+boot loader that the operating system can also be loaded from).
+
+     <br><dt>&lsquo;<samp><span class="samp">EBX</span></samp>&rsquo;<dd>Must contain the 64-bit physical address (paging mode is enabled and any
+memory space defined by the UEFI memory map is identity mapped, hence,
+virtual address equals physical address; Unified Extensible Firmware
+Interface Specification, Version 2.6, section 2.3.4, x64 Platforms, boot
+services) of the Multiboot2 information structure provided by the boot
+loader (see <a href="#Boot-information-format">Boot information format</a>). 
+</dl>
+
+   <p>All other processor registers, flag bits and state are set accordingly
+to Unified Extensible Firmware Interface Specification, Version 2.6,
+section 2.3.4, x64 Platforms, boot services.
+
+   <p>The bootloader must not load any part of the kernel, the modules, the Multiboot2
+information structure, etc. higher than 4 GiB - 1. This requirement is put in
+force because most of currently specified tags supports 32-bit addresses only. 
+Additionally, some kernels, even if they run on EFI 64-bit platform, still
+execute some parts of its initialization code in 32-bit mode.
+
+   <p>Note: If at some point there is a need for full 64-bit mode support in Multiboot2
+protocol then it should be designed very carefully. Especially it should be taken
+into account that 32-bit and 64-bit mode code should coexist in an image without
+any issue. The image should have a chance to inform the bootloader that it supports
+full 64-bit mode. If it is the case then the bootloader should provide 64-bit tags
+if it is desired and possible. Otherwise 32-bit tags should be used.
+
+<div class="node">
+<a name="Boot-information-format"></a>
+<p><hr>
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Machine-state">Machine state</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Specification">Specification</a>
+
+</div>
+
+<h3 class="section">3.6 Boot information</h3>
+
+<h4 class="subsection">3.6.1 Boot information format</h4>
+
+<p>Upon entry to the operating system, the <code>EBX</code> register contains the
+physical address of a <dfn>Multiboot2 information</dfn> data structure,
+through which the boot loader communicates vital information to the
+operating system. The operating system can use or ignore any parts of
+the structure as it chooses; all information passed by the boot loader
+is advisory only.
+
+   <p>The Multiboot2 information structure and its related substructures may be
+placed anywhere in memory by the boot loader (with the exception of the
+memory reserved for the kernel and boot modules, of course). It is the
+operating system's responsibility to avoid overwriting this memory until
+it is done using it.
+
+<h4 class="subsection">3.6.2 Basic tags structure</h4>
+
+<p>Boot information consists of fixed part and a series of tags. Its start is 8-bytes aligned.  Fixed part is as following:
+<pre class="example">             +-------------------+
+     u32     | total_size        |
+     u32     | reserved          |
+             +-------------------+
+</pre>
+   <p>&lsquo;<samp><span class="samp">total_size</span></samp>&rsquo; contains the total size of boot information including
+this field and terminating tag in bytes
+
+   <p>&lsquo;<samp><span class="samp">reserved</span></samp>&rsquo; is always set to zero and must be ignored by OS image
+
+   <p>Every tag begins with following fields:
+
+<pre class="example">             +-------------------+
+     u32     | type              |
+     u32     | size              |
+             +-------------------+
+</pre>
+   <p>&lsquo;<samp><span class="samp">type</span></samp>&rsquo; contains an identifier of contents of the rest of the tag. 
+&lsquo;<samp><span class="samp">size</span></samp>&rsquo; contains the size of tag including header fields but not including padding. 
+Tags follow one another padded when necessary in order for each tag to start at 8-bytes aligned address. Tags are terminated by a tag of type &lsquo;<samp><span class="samp">0</span></samp>&rsquo; and size &lsquo;<samp><span class="samp">8</span></samp>&rsquo;.
+
+<h4 class="subsection">3.6.3 Basic memory information</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 4          |
+     u32     | size = 16         |
+     u32     | mem_lower         |
+     u32     | mem_upper         |
+             +-------------------+
+</pre>
+   <p>&lsquo;<samp><span class="samp">mem_lower</span></samp>&rsquo; and &lsquo;<samp><span class="samp">mem_upper</span></samp>&rsquo; indicate the amount of
+lower and upper memory, respectively, in kilobytes. Lower memory starts
+at address 0, and upper memory starts at address 1 megabyte. The maximum
+possible value for lower memory is 640 kilobytes. The value returned for
+upper memory is maximally the address of the first upper memory hole
+minus 1 megabyte. It is not guaranteed to be this value.
+
+   <p>This tag may not be provided by some boot loaders on EFI platforms if EFI boot
+services are enabled and available for the loaded image (EFI boot services
+not terminated tag exists in Multiboot2 information structure).
+
+<h4 class="subsection">3.6.4 BIOS Boot device</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 5          |
+     u32     | size = 20         |
+     u32     | biosdev           |
+     u32     | partition         |
+     u32     | sub_parition      |
+             +-------------------+
+</pre>
+   <p>This tag indicates which <span class="sc">bios</span> disk device the boot
+loader loaded the OS image from. If the OS image was not loaded from a
+<span class="sc">bios</span> disk, then this tag must not be present. The operating system may
+use this field as a hint for determining its own <dfn>root</dfn> device,
+but is not required to.
+
+   <p>The &lsquo;<samp><span class="samp">biosdev</span></samp>&rsquo; contains the <span class="sc">bios</span> drive number as understood by the
+<span class="sc">bios</span> INT 0x13 low-level disk interface: e.g. 0x00 for the first
+floppy disk or 0x80 for the first hard disk.
+
+   <p>The three remaining bytes specify the boot partition. &lsquo;<samp><span class="samp">partition</span></samp>&rsquo;
+specifies the <dfn>top-level</dfn> partition number, &lsquo;<samp><span class="samp">sub_partition</span></samp>&rsquo; specifies a
+<dfn>sub-partition</dfn> in the top-level partition, etc. Partition numbers
+always start from zero. Unused partition bytes must be set to 0xFFFFFFFF. For
+example, if the disk is partitioned using a simple one-level DOS
+partitioning scheme, then &lsquo;<samp><span class="samp">partition</span></samp>&rsquo; contains the DOS partition
+number, and &lsquo;<samp><span class="samp">sub_partition</span></samp>&rsquo; if 0xFFFFFF. As another
+example, if a disk is partitioned first into DOS partitions, and then
+one of those DOS partitions is subdivided into several BSD partitions
+using BSD's <dfn>disklabel</dfn> strategy, then &lsquo;<samp><span class="samp">partition</span></samp>&rsquo; contains the DOS
+partition number and &lsquo;<samp><span class="samp">sub_partition</span></samp>&rsquo; contains the BSD sub-partition within
+that DOS partition.
+
+   <p>DOS extended partitions are indicated as partition numbers starting from
+4 and increasing, rather than as nested sub-partitions, even though the
+underlying disk layout of extended partitions is hierarchical in
+nature. For example, if the boot loader boots from the second extended
+partition on a disk partitioned in conventional DOS style, then
+&lsquo;<samp><span class="samp">partition</span></samp>&rsquo; will be 5, and &lsquo;<samp><span class="samp">sub_partiton</span></samp>&rsquo; will be 0xFFFFFFFF.
+
+<h4 class="subsection">3.6.5 Boot command line</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 1          |
+     u32     | size              |
+     u8[n]   | string            |
+             +-------------------+
+</pre>
+   <p>&lsquo;<samp><span class="samp">string</span></samp>&rsquo; contains command line. The command line is a normal C-style
+zero-terminated UTF-8 string.
+
+<h4 class="subsection">3.6.6 Modules</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 3          |
+     u32     | size              |
+     u32     | mod_start         |
+     u32     | mod_end           |
+     u8[n]   | string            |
+             +-------------------+
+</pre>
+   <p>This tag indicates to the kernel what boot module was loaded along with the
+kernel image, and where it can be found.
+
+   <p>The &lsquo;<samp><span class="samp">mod_start</span></samp>&rsquo; and &lsquo;<samp><span class="samp">mod_end</span></samp>&rsquo; contain the start and end physical addresses
+of the boot module itself. The &lsquo;<samp><span class="samp">string</span></samp>&rsquo; field provides an arbitrary string to
+be associated with that particular boot module; it is a zero-terminated
+UTF-8 string, just like the kernel command line. Typically the
+string might be a command line (e.g. if the operating system treats boot
+modules as executable programs), or a pathname (e.g. if the operating
+system treats boot modules as files in a file system), but its exact use
+is specific to the operating system.
+
+   <p>One tag appears per module. This tag type may appear multiple times.
+
+<h4 class="subsection">3.6.7 ELF-Symbols</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 9          |
+     u32     | size              |
+     u16     | num               |
+     u16     | entsize           |
+     u16     | shndx             |
+     u16     | reserved          |
+     varies  | section headers   |
+             +-------------------+
+</pre>
+   <p>This tag contains section header table from an ELF kernel, the
+size of each entry, number of entries, and the string table used as the
+index of names. They correspond to the &lsquo;<samp><span class="samp">shdr_*</span></samp>&rsquo; entries
+(&lsquo;<samp><span class="samp">shdr_num</span></samp>&rsquo;, etc.) in the Executable and Linkable Format (<span class="sc">elf</span>)
+specification in the program header. All sections are loaded, and the
+physical address fields of the <span class="sc">elf</span> section header then refer to where
+the sections are in memory (refer to the i386 <span class="sc">elf</span> documentation for
+details as to how to read the section header(s)).
+
+<h4 class="subsection">3.6.8 Memory map</h4>
+
+<p>This tag provides memory map.
+
+<pre class="example">             +-------------------+
+     u32     | type = 6          |
+     u32     | size              |
+     u32     | entry_size        |
+     u32     | entry_version     |
+     varies  | entries           |
+             +-------------------+
+</pre>
+   <p>&lsquo;<samp><span class="samp">entry_size</span></samp>&rsquo; contains the size of one entry so that in future new fields may be added to it. It's guaranteed to be a multiple of 8. &lsquo;<samp><span class="samp">entry_version</span></samp>&rsquo; is currently set at &lsquo;<samp><span class="samp">0</span></samp>&rsquo;. Future versions will increment this field. Future version are guranteed to be backward compatible with older format. Each entry has the following structure:
+
+<pre class="example">             +-------------------+
+     u64     | base_addr         |
+     u64     | length            |
+     u32     | type              |
+     u32     | reserved          |
+             +-------------------+
+</pre>
+   <p>&lsquo;<samp><span class="samp">size</span></samp>&rsquo; contains the size of current entry including this field itself. It may be bigger than 24 bytes in future versions but is guaranteed to be
+&lsquo;<samp><span class="samp">base_addr</span></samp>&rsquo; is the starting physical address. &lsquo;<samp><span class="samp">length</span></samp>&rsquo; is the size of the memory region in bytes. 
+&lsquo;<samp><span class="samp">type</span></samp>&rsquo; is the variety of address range represented, where a
+value of 1 indicates available <span class="sc">ram</span>, value of 3 indicates usable memory
+holding ACPI information, value of 4 indicates reserved memory which needs to
+be preserved on hibernation, value of 5 indicates a memory which is occupied by defective RAM modules and all other values currently
+indicated a reserved area. 
+&lsquo;<samp><span class="samp">reserved</span></samp>&rsquo; is set to &lsquo;<samp><span class="samp">0</span></samp>&rsquo; by bootloader and must be ignored by the OS image.
+
+   <p>The map provided is guaranteed to list all standard <span class="sc">ram</span> that should
+be available for normal use. This type however includes the regions occupied by kernel, mbi, segments and modules. Kernel must take care not to overwrite these regions.
+
+   <p>This tag may not be provided by some boot loaders on EFI platforms if EFI boot
+services are enabled and available for the loaded image (EFI boot services
+not terminated tag exists in Multiboot2 information structure).
+
+<h4 class="subsection">3.6.9 Boot loader name</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 2          |
+     u32     | size              |
+     u8[n]   | string            |
+             +-------------------+
+</pre>
+   <p>&lsquo;<samp><span class="samp">string</span></samp>&rsquo; contains  the name of a boot
+loader booting the kernel. The name is a normal C-style UTF-8 zero-terminated
+string.
+
+<h4 class="subsection">3.6.10 APM table</h4>
+
+<p>The tag type 10 contains <span class="sc">apm</span> table
+<pre class="example">             +----------------------+
+     u32     | type = 10            |
+     u32     | size = 28            |
+     u16     | version              |
+     u16     | cseg                 |
+     u32     | offset               |
+     u16     | cseg_16              |
+     u16     | dseg                 |
+     u16     | flags                |
+     u16     | cseg_len             |
+     u16     | cseg_16_len          |
+     u16     | dseg_len             |
+             +----------------------+
+</pre>
+   <p>The fields &lsquo;<samp><span class="samp">version</span></samp>&rsquo;, &lsquo;<samp><span class="samp">cseg</span></samp>&rsquo;, &lsquo;<samp><span class="samp">offset</span></samp>&rsquo;, &lsquo;<samp><span class="samp">cseg_16</span></samp>&rsquo;,
+&lsquo;<samp><span class="samp">dseg</span></samp>&rsquo;, &lsquo;<samp><span class="samp">flags</span></samp>&rsquo;, &lsquo;<samp><span class="samp">cseg_len</span></samp>&rsquo;, &lsquo;<samp><span class="samp">cseg_16_len</span></samp>&rsquo;,
+&lsquo;<samp><span class="samp">dseg_len</span></samp>&rsquo; indicate the version number, the protected mode 32-bit
+code segment, the offset of the entry point, the protected mode 16-bit
+code segment, the protected mode 16-bit data segment, the flags, the
+length of the protected mode 32-bit code segment, the length of the
+protected mode 16-bit code segment, and the length of the protected mode
+16-bit data segment, respectively. Only the field &lsquo;<samp><span class="samp">offset</span></samp>&rsquo; is 4
+bytes, and the others are 2 bytes. See
+<a href="http://www.microsoft.com/hwdev/busbios/amp_12.htm">Advanced Power Management (APM) BIOS Interface Specification</a>, for more information.
+
+<h4 class="subsection">3.6.11 VBE info</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 7          |
+     u32     | size = 784        |
+     u16     | vbe_mode          |
+     u16     | vbe_interface_seg |
+     u16     | vbe_interface_off |
+     u16     | vbe_interface_len |
+     u8[512] | vbe_control_info  |
+     u8[256] | vbe_mode_info     |
+             +-------------------+
+</pre>
+   <p>The fields &lsquo;<samp><span class="samp">vbe_control_info</span></samp>&rsquo; and &lsquo;<samp><span class="samp">vbe_mode_info</span></samp>&rsquo; contain
+<span class="sc">vbe</span> control information returned by the
+<span class="sc">vbe</span> Function 00h and <span class="sc">vbe</span> mode information returned by the
+<span class="sc">vbe</span> Function 01h, respectively.
+
+   <p>The field &lsquo;<samp><span class="samp">vbe_mode</span></samp>&rsquo; indicates current video mode in the format
+specified in <span class="sc">vbe</span> 3.0.
+
+   <p>The rest fields &lsquo;<samp><span class="samp">vbe_interface_seg</span></samp>&rsquo;, &lsquo;<samp><span class="samp">vbe_interface_off</span></samp>&rsquo;, and
+&lsquo;<samp><span class="samp">vbe_interface_len</span></samp>&rsquo; contain the table of a protected mode interface
+defined in <span class="sc">vbe</span> 2.0+. If this information is not available, those
+fields contain zero. Note that <span class="sc">vbe</span> 3.0 defines another protected
+mode interface which is incompatible with the old one. If you want to
+use the new protected mode interface, you will have to find the table
+yourself.
+
+<h4 class="subsection">3.6.12 Framebuffer info</h4>
+
+<pre class="example">             +--------------------+
+     u32     | type = 8           |
+     u32     | size               |
+     u64     | framebuffer_addr   |
+     u32     | framebuffer_pitch  |
+     u32     | framebuffer_width  |
+     u32     | framebuffer_height |
+     u8      | framebuffer_bpp    |
+     u8      | framebuffer_type   |
+     u8      | reserved           |
+     varies  | color_info         |
+             +--------------------+
+</pre>
+   <p>The field &lsquo;<samp><span class="samp">framebuffer_addr</span></samp>&rsquo; contains framebuffer physical address. This field is 64-bit wide but bootloader <dfn>should</dfn> set it under 4GiB if possible for compatibility with payloads which aren't aware of PAE or amd64. The field &lsquo;<samp><span class="samp">framebuffer_pitch</span></samp>&rsquo; contains pitch in bytes. The fields &lsquo;<samp><span class="samp">framebuffer_width</span></samp>&rsquo;, &lsquo;<samp><span class="samp">framebuffer_height</span></samp>&rsquo; contain framebuffer dimensions in pixels. The field &lsquo;<samp><span class="samp">framebuffer_bpp</span></samp>&rsquo; contains number of bits per pixel. &lsquo;<samp><span class="samp">reserved</span></samp>&rsquo; always contains 0 in current version of specification and must be ignored by OS image. If &lsquo;<samp><span class="samp">framebuffer_type</span></samp>&rsquo; is set to 0 it means indexed color. In this case color_info is defined as follows:
+<pre class="example">             +----------------------------------+
+     u32     | framebuffer_palette_num_colors   |
+     varies  | framebuffer_palette              |
+             +----------------------------------+
+</pre>
+   <p>&lsquo;<samp><span class="samp">framebuffer_palette</span></samp>&rsquo; is an array of colour descriptors. 
+Each colour descriptor has following structure:
+<pre class="example">             +-------------+
+     u8      | red_value   |
+     u8      | green_value |
+     u8      | blue_value  |
+             +-------------+
+</pre>
+   <p>If &lsquo;<samp><span class="samp">framebuffer_type</span></samp>&rsquo; is set to &lsquo;<samp><span class="samp">1</span></samp>&rsquo; it means direct RGB color. 
+Then color_type is defined as follows:
+
+<pre class="example">            +----------------------------------+
+     u8     | framebuffer_red_field_position   |
+     u8     | framebuffer_red_mask_size        |
+     u8     | framebuffer_green_field_position |
+     u8     | framebuffer_green_mask_size      |
+     u8     | framebuffer_blue_field_position  |
+     u8     | framebuffer_blue_mask_size       |
+            +----------------------------------+
+</pre>
+   <p>If &lsquo;<samp><span class="samp">framebuffer_type</span></samp>&rsquo; is set to &lsquo;<samp><span class="samp">2</span></samp>&rsquo; it means EGA text. In this case &lsquo;<samp><span class="samp">framebuffer_width</span></samp>&rsquo; and &lsquo;<samp><span class="samp">framebuffer_height</span></samp>&rsquo; are expressed in characters and not in pixels. &lsquo;<samp><span class="samp">framebuffer_bpp</span></samp>&rsquo; is equal 16 (16 bits per character) and &lsquo;<samp><span class="samp">framebuffer_pitch</span></samp>&rsquo; is expressed in bytes per text line. 
+All further values of &lsquo;<samp><span class="samp">framebuffer_type</span></samp>&rsquo; are reserved for future expansion
+
+<h4 class="subsection">3.6.13 EFI 32-bit system table pointer</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 11         |
+     u32     | size = 12         |
+     u32     | pointer           |
+             +-------------------+
+</pre>
+   <p>This tag contains pointer to i386 EFI system table.
+
+<h4 class="subsection">3.6.14 EFI 64-bit system table pointer</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 12         |
+     u32     | size = 16         |
+     u64     | pointer           |
+             +-------------------+
+</pre>
+   <p>This tag contains pointer to amd64 EFI system table.
+
+<h4 class="subsection">3.6.15 SMBIOS tables</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 13         |
+     u32     | size              |
+     u8      | major             |
+     u8      | minor             |
+     u8[6]   | reserved          |
+             | smbios tables     |
+             +-------------------+
+</pre>
+   <p>This tag contains a copy of SMBIOS tables as well as their version.
+
+<h4 class="subsection">3.6.16 ACPI old RSDP</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 14         |
+     u32     | size              |
+             | copy of RSDPv1    |
+             +-------------------+
+</pre>
+   <p>This tag contains a copy of RSDP as defined per ACPI 1.0 specification.
+
+<h4 class="subsection">3.6.17 ACPI new RSDP</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 15         |
+     u32     | size              |
+             | copy of RSDPv2    |
+             +-------------------+
+</pre>
+   <p>This tag contains a copy of RSDP as defined per ACPI 2.0 or later specification.
+
+<h4 class="subsection">3.6.18 Networking information</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 16         |
+     u32     | size              |
+             | DHCP ACK          |
+             +-------------------+
+</pre>
+   <p>This tag contains network information in the format specified as DHCP. It may be either a real DHCP reply or just the configuration info in the same format. This tag appears once per card.
+
+<h4 class="subsection">3.6.19 EFI memory map</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 17         |
+     u32     | size              |
+     u32     | descriptor size   |
+     u32     | descriptor version|
+             | EFI memory map    |
+             +-------------------+
+</pre>
+   <p>This tag contains EFI memory map as per EFI specification.
+
+   <p>This tag may not be provided by some boot loaders on EFI platforms if EFI boot
+services are enabled and available for the loaded image (EFI boot services
+not terminated tag exists in Multiboot2 information structure).
+
+<h4 class="subsection">3.6.20 EFI boot services not terminated</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 18         |
+     u32     | size = 8          |
+             +-------------------+
+</pre>
+   <p>This tag indicates ExitBootServices wasn't called
+
+<h4 class="subsection">3.6.21 EFI 32-bit image handle pointer</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 19         |
+     u32     | size = 12         |
+     u32     | pointer           |
+             +-------------------+
+</pre>
+   <p>This tag contains pointer to EFI i386 image handle. 
+Usually it is boot loader image handle.
+
+<h4 class="subsection">3.6.22 EFI 64-bit image handle pointer</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 20         |
+     u32     | size = 16         |
+     u64     | pointer           |
+             +-------------------+
+</pre>
+   <p>This tag contains pointer to EFI amd64 image handle. 
+Usually it is boot loader image handle.
+
+<h4 class="subsection">3.6.23 Image load base physical address</h4>
+
+<pre class="example">             +-------------------+
+     u32     | type = 21         |
+     u32     | size = 12         |
+     u32     | load_base_addr    |
+             +-------------------+
+</pre>
+   <p>This tag contains image load base physical address. It is
+provided only if image has relocatable header tag.
+
+<div class="node">
+<a name="Examples"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#History">History</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Specification">Specification</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>
+
+</div>
+
+<h2 class="chapter">4 Examples</h2>
+
+<p><strong>Caution:</strong> The following items are not part of the specification
+document, but are included for prospective operating system and boot
+loader writers.
+
+<ul class="menu">
+<li><a accesskey="1" href="#C-structure-members-alignment-and-padding-consideration">C structure members alignment and padding consideration</a>
+<li><a accesskey="2" href="#Notes-on-PC">Notes on PC</a>
+<li><a accesskey="3" href="#BIOS-device-mapping-techniques">BIOS device mapping techniques</a>
+<li><a accesskey="4" href="#Example-OS-code">Example OS code</a>
+<li><a accesskey="5" href="#Example-boot-loader-code">Example boot loader code</a>
+</ul>
+
+<div class="node">
+<a name="C-structure-members-alignment-and-padding-consideration"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Notes-on-PC">Notes on PC</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Examples">Examples</a>
+
+</div>
+
+<h3 class="section">4.1 C structure members alignment and padding consideration</h3>
+
+<p>It is preferred that the structures used for communication between the bootloader
+and the OS image conform to chosen ABI for a given architecture. If it is not
+possible then GCC &lsquo;<samp><span class="samp">__attribute__ ((__packed__))</span></samp>&rsquo; (or anything else which has
+similar meaning for chosen C compiler) have to be added to relevant structures
+definitions to avoid spurious, in this case, padding and alignment.
+
+<div class="node">
+<a name="Notes-on-PC"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#BIOS-device-mapping-techniques">BIOS device mapping techniques</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#C-structure-members-alignment-and-padding-consideration">C structure members alignment and padding consideration</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Examples">Examples</a>
+
+</div>
+
+<h3 class="section">4.2 Notes on PC</h3>
+
+<p>In reference to bit 0 of the &lsquo;<samp><span class="samp">flags</span></samp>&rsquo; parameter in the Multiboot2
+information structure, if the bootloader in question uses older
+<span class="sc">bios</span> interfaces, or the newest ones are not available (see
+description about bit 6), then a maximum of either 15 or 63 megabytes of
+memory may be reported. It is <em>highly</em> recommended that boot
+loaders perform a thorough memory probe.
+
+   <p>In reference to bit 1 of the &lsquo;<samp><span class="samp">flags</span></samp>&rsquo; parameter in the Multiboot2
+information structure, it is recognized that determination of which
+<span class="sc">bios</span> drive maps to which device driver in an operating system is
+non-trivial, at best. Many kludges have been made to various operating
+systems instead of solving this problem, most of them breaking under
+many conditions. To encourage the use of general-purpose solutions to
+this problem, there are 2 <span class="sc">bios</span> device mapping techniques
+(see <a href="#BIOS-device-mapping-techniques">BIOS device mapping techniques</a>).
+
+   <p>In reference to bit 6 of the &lsquo;<samp><span class="samp">flags</span></samp>&rsquo; parameter in the Multiboot2
+information structure, it is important to note that the data structure
+used there (starting with &lsquo;<samp><span class="samp">BaseAddrLow</span></samp>&rsquo;) is the data returned by
+the INT 15h, AX=E820h &mdash; Query System Address Map call. See See <a href="grub.html#Query-System-Address-Map">Query System Address Map</a>, for more information. The interface here is meant to allow a
+boot loader to work unmodified with any reasonable extensions of the
+<span class="sc">bios</span> interface, passing along any extra data to be interpreted by
+the operating system as desired.
+
+<div class="node">
+<a name="BIOS-device-mapping-techniques"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Example-OS-code">Example OS code</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Notes-on-PC">Notes on PC</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Examples">Examples</a>
+
+</div>
+
+<h3 class="section">4.3 BIOS device mapping techniques</h3>
+
+<p>Both of these techniques should be usable from any PC operating system,
+and neither require any special support in the drivers themselves. This
+section will be flushed out into detailed explanations, particularly for
+the I/O restriction technique.
+
+   <p>The general rule is that the data comparison technique is the quick and
+dirty solution. It works most of the time, but doesn't cover all the
+bases, and is relatively simple.
+
+   <p>The I/O restriction technique is much more complex, but it has potential
+to solve the problem under all conditions, plus allow access of the
+remaining <span class="sc">bios</span> devices when not all of them have operating system
+drivers.
+
+<ul class="menu">
+<li><a accesskey="1" href="#Data-comparison-technique">Data comparison technique</a>
+<li><a accesskey="2" href="#I_002fO-restriction-technique">I/O restriction technique</a>
+</ul>
+
+<div class="node">
+<a name="Data-comparison-technique"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#I_002fO-restriction-technique">I/O restriction technique</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#BIOS-device-mapping-techniques">BIOS device mapping techniques</a>
+
+</div>
+
+<h4 class="subsection">4.3.1 Data comparison technique</h4>
+
+<p>Before activating <em>any</em> of the device drivers, gather enough data
+from similar sectors on each of the disks such that each one can be
+uniquely identified.
+
+   <p>After activating the device drivers, compare data from the drives using
+the operating system drivers. This should hopefully be sufficient to
+provide such a mapping.
+
+   <p>Problems:
+
+     <ol type=1 start=1>
+<li>The data on some <span class="sc">bios</span> devices might be identical (so the part
+reading the drives from the <span class="sc">bios</span> should have some mechanism to give
+up).
+
+     <li>There might be extra drives not accessible from the <span class="sc">bios</span> which are
+identical to some drive used by the <span class="sc">bios</span> (so it should be capable
+of giving up there as well).
+        </ol>
+
+<div class="node">
+<a name="I%2fO-restriction-technique"></a>
+<a name="I_002fO-restriction-technique"></a>
+<p><hr>
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Data-comparison-technique">Data comparison technique</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#BIOS-device-mapping-techniques">BIOS device mapping techniques</a>
+
+</div>
+
+<h4 class="subsection">4.3.2 I/O restriction technique</h4>
+
+<p>This first step may be unnecessary, but first create copy-on-write
+mappings for the device drivers writing into <span class="sc">pc</span> <span class="sc">ram</span>. Keep the
+original copies for the <dfn>clean </dfn><span class="sc">bios</span><dfn> virtual machine</dfn> to be
+created later.
+
+   <p>For each device driver brought online, determine which <span class="sc">bios</span> devices
+become inaccessible by:
+
+     <ol type=1 start=1>
+<li>Create a <dfn>clean </dfn><span class="sc">bios</span><dfn> virtual machine</dfn>.
+
+     <li>Set the I/O permission map for the I/O area claimed by the device driver
+to no permissions (neither read nor write).
+
+     <li>Access each device.
+
+     <li>Record which devices succeed, and those which try to access the
+<dfn>restricted</dfn> I/O areas (hopefully, this will be an <dfn>xor</dfn>
+situation).
+        </ol>
+
+   <p>For each device driver, given how many of the <span class="sc">bios</span> devices were
+subsumed by it (there should be no gaps in this list), it should be easy
+to determine which devices on the controller these are.
+
+   <p>In general, you have at most 2 disks from each controller given
+<span class="sc">bios</span> numbers, but they pretty much always count from the lowest
+logically numbered devices on the controller.
+
+<div class="node">
+<a name="Example-OS-code"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Example-boot-loader-code">Example boot loader code</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#BIOS-device-mapping-techniques">BIOS device mapping techniques</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Examples">Examples</a>
+
+</div>
+
+<h3 class="section">4.4 Example OS code</h3>
+
+<p>In this distribution, the example Multiboot2 kernel <samp><span class="file">kernel</span></samp> is
+included. The kernel just prints out the Multiboot2 information structure
+on the screen, so you can make use of the kernel to test a
+Multiboot2-compliant boot loader and for reference to how to implement a
+Multiboot2 kernel. The source files can be found under the directory
+<samp><span class="file">doc</span></samp> in the Multiboot2 source distribution.
+
+   <p>The kernel <samp><span class="file">kernel</span></samp> consists of only three files: <samp><span class="file">boot.S</span></samp>,
+<samp><span class="file">kernel.c</span></samp> and <samp><span class="file">multiboot2.h</span></samp>. The assembly source
+<samp><span class="file">boot.S</span></samp> is written in GAS (see <a href="as.html#Top">GNU assembler</a>), and contains the Multiboot2 information structure to
+comply with the specification. When a Multiboot2-compliant boot loader
+loads and execute it, it initialize the stack pointer and <code>EFLAGS</code>,
+and then call the function <code>cmain</code> defined in <samp><span class="file">kernel.c</span></samp>. If
+<code>cmain</code> returns to the callee, then it shows a message to inform
+the user of the halt state and stops forever until you push the reset
+key. The file <samp><span class="file">kernel.c</span></samp> contains the function <code>cmain</code>,
+which checks if the magic number passed by the boot loader is valid and
+so on, and some functions to print messages on the screen. The file
+<samp><span class="file">multiboot2.h</span></samp> defines some macros, such as the magic number for the
+Multiboot2 header, the Multiboot2 header structure and the Multiboot2
+information structure.
+
+<ul class="menu">
+<li><a accesskey="1" href="#multiboot2_002eh">multiboot2.h</a>
+<li><a accesskey="2" href="#boot_002eS">boot.S</a>
+<li><a accesskey="3" href="#kernel_002ec">kernel.c</a>
+<li><a accesskey="4" href="#Other-Multiboot2-kernels">Other Multiboot2 kernels</a>
+</ul>
+
+<div class="node">
+<a name="multiboot2.h"></a>
+<a name="multiboot2_002eh"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#boot_002eS">boot.S</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Example-OS-code">Example OS code</a>
+
+</div>
+
+<h4 class="subsection">4.4.1 multiboot2.h</h4>
+
+<p>This is the source code in the file <samp><span class="file">multiboot2.h</span></samp>:
+
+<pre class="example">     /* <span class="roman">  multiboot2.h - Multiboot 2 header file.</span> */
+     /* <span class="roman">  Copyright (C) 1999,2003,2007,2008,2009,2010  Free Software Foundation, Inc.
+      *
+      *  Permission is hereby granted, free of charge, to any person obtaining a copy
+      *  of this software and associated documentation files (the "Software"), to
+      *  deal in the Software without restriction, including without limitation the
+      *  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+      *  sell copies of the Software, and to permit persons to whom the Software is
+      *  furnished to do so, subject to the following conditions:
+      *
+      *  The above copyright notice and this permission notice shall be included in
+      *  all copies or substantial portions of the Software.
+      *
+      *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+      *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+      *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL ANY
+      *  DEVELOPER OR DISTRIBUTOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+      *  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
+      *  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+     </span> */
+     
+     #ifndef MULTIBOOT_HEADER
+     #define MULTIBOOT_HEADER 1
+     
+     /* <span class="roman"> How many bytes from the start of the file we search for the header.</span> */
+     #define MULTIBOOT_SEARCH                        32768
+     #define MULTIBOOT_HEADER_ALIGN                  8
+     
+     /* <span class="roman"> The magic field should contain this.</span> */
+     #define MULTIBOOT2_HEADER_MAGIC                 0xe85250d6
+     
+     /* <span class="roman"> This should be in %eax.</span> */
+     #define MULTIBOOT2_BOOTLOADER_MAGIC             0x36d76289
+     
+     /* <span class="roman"> Alignment of multiboot modules.</span> */
+     #define MULTIBOOT_MOD_ALIGN                     0x00001000
+     
+     /* <span class="roman"> Alignment of the multiboot info structure.</span> */
+     #define MULTIBOOT_INFO_ALIGN                    0x00000008
+     
+     /* <span class="roman"> Flags set in the 'flags' member of the multiboot header.</span> */
+     
+     #define MULTIBOOT_TAG_ALIGN                  8
+     #define MULTIBOOT_TAG_TYPE_END               0
+     #define MULTIBOOT_TAG_TYPE_CMDLINE           1
+     #define MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME  2
+     #define MULTIBOOT_TAG_TYPE_MODULE            3
+     #define MULTIBOOT_TAG_TYPE_BASIC_MEMINFO     4
+     #define MULTIBOOT_TAG_TYPE_BOOTDEV           5
+     #define MULTIBOOT_TAG_TYPE_MMAP              6
+     #define MULTIBOOT_TAG_TYPE_VBE               7
+     #define MULTIBOOT_TAG_TYPE_FRAMEBUFFER       8
+     #define MULTIBOOT_TAG_TYPE_ELF_SECTIONS      9
+     #define MULTIBOOT_TAG_TYPE_APM               10
+     #define MULTIBOOT_TAG_TYPE_EFI32             11
+     #define MULTIBOOT_TAG_TYPE_EFI64             12
+     #define MULTIBOOT_TAG_TYPE_SMBIOS            13
+     #define MULTIBOOT_TAG_TYPE_ACPI_OLD          14
+     #define MULTIBOOT_TAG_TYPE_ACPI_NEW          15
+     #define MULTIBOOT_TAG_TYPE_NETWORK           16
+     #define MULTIBOOT_TAG_TYPE_EFI_MMAP          17
+     #define MULTIBOOT_TAG_TYPE_EFI_BS            18
+     #define MULTIBOOT_TAG_TYPE_EFI32_IH          19
+     #define MULTIBOOT_TAG_TYPE_EFI64_IH          20
+     #define MULTIBOOT_TAG_TYPE_LOAD_BASE_ADDR    21
+     
+     #define MULTIBOOT_HEADER_TAG_END  0
+     #define MULTIBOOT_HEADER_TAG_INFORMATION_REQUEST  1
+     #define MULTIBOOT_HEADER_TAG_ADDRESS  2
+     #define MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS  3
+     #define MULTIBOOT_HEADER_TAG_CONSOLE_FLAGS  4
+     #define MULTIBOOT_HEADER_TAG_FRAMEBUFFER  5
+     #define MULTIBOOT_HEADER_TAG_MODULE_ALIGN  6
+     #define MULTIBOOT_HEADER_TAG_EFI_BS        7
+     #define MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS_EFI32  8
+     #define MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS_EFI64  9
+     #define MULTIBOOT_HEADER_TAG_RELOCATABLE  10
+     
+     #define MULTIBOOT_ARCHITECTURE_I386  0
+     #define MULTIBOOT_ARCHITECTURE_MIPS32  4
+     #define MULTIBOOT_HEADER_TAG_OPTIONAL 1
+     
+     #define MULTIBOOT_LOAD_PREFERENCE_NONE 0
+     #define MULTIBOOT_LOAD_PREFERENCE_LOW 1
+     #define MULTIBOOT_LOAD_PREFERENCE_HIGH 2
+     
+     #define MULTIBOOT_CONSOLE_FLAGS_CONSOLE_REQUIRED 1
+     #define MULTIBOOT_CONSOLE_FLAGS_EGA_TEXT_SUPPORTED 2
+     
+     #ifndef ASM_FILE
+     
+     typedef unsigned char           multiboot_uint8_t;
+     typedef unsigned short          multiboot_uint16_t;
+     typedef unsigned int            multiboot_uint32_t;
+     typedef unsigned long long      multiboot_uint64_t;
+     
+     struct multiboot_header
+     {
+       /* <span class="roman"> Must be MULTIBOOT_MAGIC - see above.</span> */
+       multiboot_uint32_t magic;
+     
+       /* <span class="roman"> ISA</span> */
+       multiboot_uint32_t architecture;
+     
+       /* <span class="roman"> Total header length.</span> */
+       multiboot_uint32_t header_length;
+     
+       /* <span class="roman"> The above fields plus this one must equal 0 mod 2^32.</span> */
+       multiboot_uint32_t checksum;
+     };
+     
+     struct multiboot_header_tag
+     {
+       multiboot_uint16_t type;
+       multiboot_uint16_t flags;
+       multiboot_uint32_t size;
+     };
+     
+     struct multiboot_header_tag_information_request
+     {
+       multiboot_uint16_t type;
+       multiboot_uint16_t flags;
+       multiboot_uint32_t size;
+       multiboot_uint32_t requests[0];
+     };
+     
+     struct multiboot_header_tag_address
+     {
+       multiboot_uint16_t type;
+       multiboot_uint16_t flags;
+       multiboot_uint32_t size;
+       multiboot_uint32_t header_addr;
+       multiboot_uint32_t load_addr;
+       multiboot_uint32_t load_end_addr;
+       multiboot_uint32_t bss_end_addr;
+     };
+     
+     struct multiboot_header_tag_entry_address
+     {
+       multiboot_uint16_t type;
+       multiboot_uint16_t flags;
+       multiboot_uint32_t size;
+       multiboot_uint32_t entry_addr;
+     };
+     
+     struct multiboot_header_tag_console_flags
+     {
+       multiboot_uint16_t type;
+       multiboot_uint16_t flags;
+       multiboot_uint32_t size;
+       multiboot_uint32_t console_flags;
+     };
+     
+     struct multiboot_header_tag_framebuffer
+     {
+       multiboot_uint16_t type;
+       multiboot_uint16_t flags;
+       multiboot_uint32_t size;
+       multiboot_uint32_t width;
+       multiboot_uint32_t height;
+       multiboot_uint32_t depth;
+     };
+     
+     struct multiboot_header_tag_module_align
+     {
+       multiboot_uint16_t type;
+       multiboot_uint16_t flags;
+       multiboot_uint32_t size;
+     };
+     
+     struct multiboot_header_tag_relocatable
+     {
+       multiboot_uint16_t type;
+       multiboot_uint16_t flags;
+       multiboot_uint32_t size;
+       multiboot_uint32_t min_addr;
+       multiboot_uint32_t max_addr;
+       multiboot_uint32_t align;
+       multiboot_uint32_t preference;
+     };
+     
+     struct multiboot_color
+     {
+       multiboot_uint8_t red;
+       multiboot_uint8_t green;
+       multiboot_uint8_t blue;
+     };
+     
+     struct multiboot_mmap_entry
+     {
+       multiboot_uint64_t addr;
+       multiboot_uint64_t len;
+     #define MULTIBOOT_MEMORY_AVAILABLE              1
+     #define MULTIBOOT_MEMORY_RESERVED               2
+     #define MULTIBOOT_MEMORY_ACPI_RECLAIMABLE       3
+     #define MULTIBOOT_MEMORY_NVS                    4
+     #define MULTIBOOT_MEMORY_BADRAM                 5
+       multiboot_uint32_t type;
+       multiboot_uint32_t zero;
+     };
+     typedef struct multiboot_mmap_entry multiboot_memory_map_t;
+     
+     struct multiboot_tag
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+     };
+     
+     struct multiboot_tag_string
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       char string[0];
+     };
+     
+     struct multiboot_tag_module
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint32_t mod_start;
+       multiboot_uint32_t mod_end;
+       char cmdline[0];
+     };
+     
+     struct multiboot_tag_basic_meminfo
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint32_t mem_lower;
+       multiboot_uint32_t mem_upper;
+     };
+     
+     struct multiboot_tag_bootdev
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint32_t biosdev;
+       multiboot_uint32_t slice;
+       multiboot_uint32_t part;
+     };
+     
+     struct multiboot_tag_mmap
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint32_t entry_size;
+       multiboot_uint32_t entry_version;
+       struct multiboot_mmap_entry entries[0];
+     };
+     
+     struct multiboot_vbe_info_block
+     {
+       multiboot_uint8_t external_specification[512];
+     };
+     
+     struct multiboot_vbe_mode_info_block
+     {
+       multiboot_uint8_t external_specification[256];
+     };
+     
+     struct multiboot_tag_vbe
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+     
+       multiboot_uint16_t vbe_mode;
+       multiboot_uint16_t vbe_interface_seg;
+       multiboot_uint16_t vbe_interface_off;
+       multiboot_uint16_t vbe_interface_len;
+     
+       struct multiboot_vbe_info_block vbe_control_info;
+       struct multiboot_vbe_mode_info_block vbe_mode_info;
+     };
+     
+     struct multiboot_tag_framebuffer_common
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+     
+       multiboot_uint64_t framebuffer_addr;
+       multiboot_uint32_t framebuffer_pitch;
+       multiboot_uint32_t framebuffer_width;
+       multiboot_uint32_t framebuffer_height;
+       multiboot_uint8_t framebuffer_bpp;
+     #define MULTIBOOT_FRAMEBUFFER_TYPE_INDEXED 0
+     #define MULTIBOOT_FRAMEBUFFER_TYPE_RGB     1
+     #define MULTIBOOT_FRAMEBUFFER_TYPE_EGA_TEXT     2
+       multiboot_uint8_t framebuffer_type;
+       multiboot_uint16_t reserved;
+     };
+     
+     struct multiboot_tag_framebuffer
+     {
+       struct multiboot_tag_framebuffer_common common;
+     
+       union
+       {
+         struct
+         {
+           multiboot_uint16_t framebuffer_palette_num_colors;
+           struct multiboot_color framebuffer_palette[0];
+         };
+         struct
+         {
+           multiboot_uint8_t framebuffer_red_field_position;
+           multiboot_uint8_t framebuffer_red_mask_size;
+           multiboot_uint8_t framebuffer_green_field_position;
+           multiboot_uint8_t framebuffer_green_mask_size;
+           multiboot_uint8_t framebuffer_blue_field_position;
+           multiboot_uint8_t framebuffer_blue_mask_size;
+         };
+       };
+     };
+     
+     struct multiboot_tag_elf_sections
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint32_t num;
+       multiboot_uint32_t entsize;
+       multiboot_uint32_t shndx;
+       char sections[0];
+     };
+     
+     struct multiboot_tag_apm
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint16_t version;
+       multiboot_uint16_t cseg;
+       multiboot_uint32_t offset;
+       multiboot_uint16_t cseg_16;
+       multiboot_uint16_t dseg;
+       multiboot_uint16_t flags;
+       multiboot_uint16_t cseg_len;
+       multiboot_uint16_t cseg_16_len;
+       multiboot_uint16_t dseg_len;
+     };
+     
+     struct multiboot_tag_efi32
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint32_t pointer;
+     };
+     
+     struct multiboot_tag_efi64
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint64_t pointer;
+     };
+     
+     struct multiboot_tag_smbios
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint8_t major;
+       multiboot_uint8_t minor;
+       multiboot_uint8_t reserved[6];
+       multiboot_uint8_t tables[0];
+     };
+     
+     struct multiboot_tag_old_acpi
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint8_t rsdp[0];
+     };
+     
+     struct multiboot_tag_new_acpi
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint8_t rsdp[0];
+     };
+     
+     struct multiboot_tag_network
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint8_t dhcpack[0];
+     };
+     
+     struct multiboot_tag_efi_mmap
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint32_t descr_size;
+       multiboot_uint32_t descr_vers;
+       multiboot_uint8_t efi_mmap[0];
+     };
+     
+     struct multiboot_tag_efi32_ih
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint32_t pointer;
+     };
+     
+     struct multiboot_tag_efi64_ih
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint64_t pointer;
+     };
+     
+     struct multiboot_tag_load_base_addr
+     {
+       multiboot_uint32_t type;
+       multiboot_uint32_t size;
+       multiboot_uint32_t load_base_addr;
+     };
+     
+     #endif /* <span class="roman"> ! ASM_FILE</span> */
+     
+     #endif /* <span class="roman"> ! MULTIBOOT_HEADER</span> */
+</pre>
+   <div class="node">
+<a name="boot.S"></a>
+<a name="boot_002eS"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#kernel_002ec">kernel.c</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#multiboot2_002eh">multiboot2.h</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Example-OS-code">Example OS code</a>
+
+</div>
+
+<h4 class="subsection">4.4.2 boot.S</h4>
+
+<p>In the file <samp><span class="file">boot.S</span></samp>:
+
+<pre class="example">     /* <span class="roman"> boot.S - bootstrap the kernel</span> */
+     /* <span class="roman"> Copyright (C) 1999, 2001, 2010  Free Software Foundation, Inc.
+      *
+      * This program is free software: you can redistribute it and/or modify
+      * it under the terms of the GNU General Public License as published by
+      * the Free Software Foundation, either version 3 of the License, or
+      * (at your option) any later version.
+      *
+      * This program is distributed in the hope that it will be useful,
+      * but WITHOUT ANY WARRANTY; without even the implied warranty of
+      * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+      * GNU General Public License for more details.
+      *
+      * You should have received a copy of the GNU General Public License
+      * along with this program.  If not, see &lt;http://www.gnu.org/licenses/&gt;.
+     </span> */
+     
+     #define ASM_FILE        1
+     #include &lt;multiboot2.h&gt;
+     
+     /* <span class="roman"> C symbol format. HAVE_ASM_USCORE is defined by configure.</span> */
+     #ifdef HAVE_ASM_USCORE
+     # define EXT_C(sym)                     _ ## sym
+     #else
+     # define EXT_C(sym)                     sym
+     #endif
+     
+     /* <span class="roman"> The size of our stack (16KB).</span> */
+     #define STACK_SIZE                      0x4000
+     
+     /* <span class="roman"> The flags for the Multiboot header.</span> */
+     #ifdef __ELF__
+     # define AOUT_KLUDGE 0
+     #else
+     # define AOUT_KLUDGE MULTIBOOT_AOUT_KLUDGE
+     #endif
+     
+             .text
+     
+             .globl  start, _start
+     start:
+     _start:
+             jmp     multiboot_entry
+     
+             /* <span class="roman"> Align 64 bits boundary.</span> */
+             .align  8
+     
+             /* <span class="roman"> Multiboot header.</span> */
+     multiboot_header:
+             /* <span class="roman"> magic</span> */
+             .long   MULTIBOOT2_HEADER_MAGIC
+             /* <span class="roman"> ISA: i386</span> */
+             .long   GRUB_MULTIBOOT_ARCHITECTURE_I386
+             /* <span class="roman"> Header length.</span> */
+             .long   multiboot_header_end - multiboot_header
+             /* <span class="roman"> checksum</span> */
+             .long   -(MULTIBOOT2_HEADER_MAGIC + GRUB_MULTIBOOT_ARCHITECTURE_I386 + (multiboot_header_end - multiboot_header))
+     #ifndef __ELF__
+     address_tag_start:
+             .short MULTIBOOT_HEADER_TAG_ADDRESS
+             .short MULTIBOOT_HEADER_TAG_OPTIONAL
+             .long address_tag_end - address_tag_start
+             /* <span class="roman"> header_addr</span> */
+             .long   multiboot_header
+             /* <span class="roman"> load_addr</span> */
+             .long   _start
+             /* <span class="roman"> load_end_addr</span> */
+             .long   _edata
+             /* <span class="roman"> bss_end_addr</span> */
+             .long   _end
+     address_tag_end:
+     entry_address_tag_start:
+             .short MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS
+             .short MULTIBOOT_HEADER_TAG_OPTIONAL
+             .long entry_address_tag_end - entry_address_tag_start
+             /* <span class="roman"> entry_addr</span> */
+             .long multiboot_entry
+     entry_address_tag_end:
+     #endif /* <span class="roman"> __ELF__</span> */
+     framebuffer_tag_start:
+             .short MULTIBOOT_HEADER_TAG_FRAMEBUFFER
+             .short MULTIBOOT_HEADER_TAG_OPTIONAL
+             .long framebuffer_tag_end - framebuffer_tag_start
+             .long 1024
+             .long 768
+             .long 32
+     framebuffer_tag_end:
+             .short MULTIBOOT_HEADER_TAG_END
+             .short 0
+             .long 8
+     multiboot_header_end:
+     multiboot_entry:
+             /* <span class="roman"> Initialize the stack pointer.</span> */
+             movl    $(stack + STACK_SIZE), %esp
+     
+             /* <span class="roman"> Reset EFLAGS.</span> */
+             pushl   $0
+             popf
+     
+             /* <span class="roman"> Push the pointer to the Multiboot information structure.</span> */
+             pushl   %ebx
+             /* <span class="roman"> Push the magic value.</span> */
+             pushl   %eax
+     
+             /* <span class="roman"> Now enter the C main function...</span> */
+             call    EXT_C(cmain)
+     
+             /* <span class="roman"> Halt.</span> */
+             pushl   $halt_message
+             call    EXT_C(printf)
+     
+     loop:   hlt
+             jmp     loop
+     
+     halt_message:
+             .asciz  "Halted."
+     
+             /* <span class="roman"> Our stack area.</span> */
+             .comm   stack, STACK_SIZE
+</pre>
+   <div class="node">
+<a name="kernel.c"></a>
+<a name="kernel_002ec"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Other-Multiboot2-kernels">Other Multiboot2 kernels</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#boot_002eS">boot.S</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Example-OS-code">Example OS code</a>
+
+</div>
+
+<h4 class="subsection">4.4.3 kernel.c</h4>
+
+<p>And, in the file <samp><span class="file">kernel.c</span></samp>:
+
+<pre class="example">     /* <span class="roman"> kernel.c - the C part of the kernel</span> */
+     /* <span class="roman"> Copyright (C) 1999, 2010  Free Software Foundation, Inc.
+      *
+      * This program is free software: you can redistribute it and/or modify
+      * it under the terms of the GNU General Public License as published by
+      * the Free Software Foundation, either version 3 of the License, or
+      * (at your option) any later version.
+      *
+      * This program is distributed in the hope that it will be useful,
+      * but WITHOUT ANY WARRANTY; without even the implied warranty of
+      * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+      * GNU General Public License for more details.
+      *
+      * You should have received a copy of the GNU General Public License
+      * along with this program.  If not, see &lt;http://www.gnu.org/licenses/&gt;.
+     </span> */
+     
+     #include "multiboot2.h"
+     
+     /* <span class="roman"> Macros.</span> */
+     
+     /* <span class="roman"> Some screen stuff.</span> */
+     /* <span class="roman"> The number of columns.</span> */
+     #define COLUMNS                 80
+     /* <span class="roman"> The number of lines.</span> */
+     #define LINES                   24
+     /* <span class="roman"> The attribute of an character.</span> */
+     #define ATTRIBUTE               7
+     /* <span class="roman"> The video memory address.</span> */
+     #define VIDEO                   0xB8000
+     
+     /* <span class="roman"> Variables.</span> */
+     /* <span class="roman"> Save the X position.</span> */
+     static int xpos;
+     /* <span class="roman"> Save the Y position.</span> */
+     static int ypos;
+     /* <span class="roman"> Point to the video memory.</span> */
+     static volatile unsigned char *video;
+     
+     /* <span class="roman"> Forward declarations.</span> */
+     void cmain (unsigned long magic, unsigned long addr);
+     static void cls (void);
+     static void itoa (char *buf, int base, int d);
+     static void putchar (int c);
+     void printf (const char *format, ...);
+     
+     /* <span class="roman"> Check if MAGIC is valid and print the Multiboot information structure
+        pointed by ADDR.</span> */
+     void
+     cmain (unsigned long magic, unsigned long addr)
+     {
+       struct multiboot_tag *tag;
+       unsigned size;
+     
+       /* <span class="roman"> Clear the screen.</span> */
+       cls ();
+     
+       /* <span class="roman"> Am I booted by a Multiboot-compliant boot loader?</span> */
+       if (magic != MULTIBOOT2_BOOTLOADER_MAGIC)
+         {
+           printf ("Invalid magic number: 0x%x\n", (unsigned) magic);
+           return;
+         }
+     
+       if (addr &amp; 7)
+         {
+           printf ("Unaligned mbi: 0x%x\n", addr);
+           return;
+         }
+     
+       size = *(unsigned *) addr;
+       printf ("Announced mbi size 0x%x\n", size);
+       for (tag = (struct multiboot_tag *) (addr + 8);
+            tag-&gt;type != MULTIBOOT_TAG_TYPE_END;
+            tag = (struct multiboot_tag *) ((multiboot_uint8_t *) tag
+                                            + ((tag-&gt;size + 7) &amp; ~7)))
+         {
+           printf ("Tag 0x%x, Size 0x%x\n", tag-&gt;type, tag-&gt;size);
+           switch (tag-&gt;type)
+             {
+             case MULTIBOOT_TAG_TYPE_CMDLINE:
+               printf ("Command line = %s\n",
+                       ((struct multiboot_tag_string *) tag)-&gt;string);
+               break;
+             case MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME:
+               printf ("Boot loader name = %s\n",
+                       ((struct multiboot_tag_string *) tag)-&gt;string);
+               break;
+             case MULTIBOOT_TAG_TYPE_MODULE:
+               printf ("Module at 0x%x-0x%x. Command line %s\n",
+                       ((struct multiboot_tag_module *) tag)-&gt;mod_start,
+                       ((struct multiboot_tag_module *) tag)-&gt;mod_end,
+                       ((struct multiboot_tag_module *) tag)-&gt;cmdline);
+               break;
+             case MULTIBOOT_TAG_TYPE_BASIC_MEMINFO:
+               printf ("mem_lower = %uKB, mem_upper = %uKB\n",
+                       ((struct multiboot_tag_basic_meminfo *) tag)-&gt;mem_lower,
+                       ((struct multiboot_tag_basic_meminfo *) tag)-&gt;mem_upper);
+               break;
+             case MULTIBOOT_TAG_TYPE_BOOTDEV:
+               printf ("Boot device 0x%x,%u,%u\n",
+                       ((struct multiboot_tag_bootdev *) tag)-&gt;biosdev,
+                       ((struct multiboot_tag_bootdev *) tag)-&gt;slice,
+                       ((struct multiboot_tag_bootdev *) tag)-&gt;part);
+               break;
+             case MULTIBOOT_TAG_TYPE_MMAP:
+               {
+                 multiboot_memory_map_t *mmap;
+     
+                 printf ("mmap\n");
+     
+                 for (mmap = ((struct multiboot_tag_mmap *) tag)-&gt;entries;
+                      (multiboot_uint8_t *) mmap
+                        &lt; (multiboot_uint8_t *) tag + tag-&gt;size;
+                      mmap = (multiboot_memory_map_t *)
+                        ((unsigned long) mmap
+                         + ((struct multiboot_tag_mmap *) tag)-&gt;entry_size))
+                   printf (" base_addr = 0x%x%x,"
+                           " length = 0x%x%x, type = 0x%x\n",
+                           (unsigned) (mmap-&gt;addr &gt;&gt; 32),
+                           (unsigned) (mmap-&gt;addr &amp; 0xffffffff),
+                           (unsigned) (mmap-&gt;len &gt;&gt; 32),
+                           (unsigned) (mmap-&gt;len &amp; 0xffffffff),
+                           (unsigned) mmap-&gt;type);
+               }
+               break;
+             case MULTIBOOT_TAG_TYPE_FRAMEBUFFER:
+               {
+                 multiboot_uint32_t color;
+                 unsigned i;
+                 struct multiboot_tag_framebuffer *tagfb
+                   = (struct multiboot_tag_framebuffer *) tag;
+                 void *fb = (void *) (unsigned long) tagfb-&gt;common.framebuffer_addr;
+     
+                 switch (tagfb-&gt;common.framebuffer_type)
+                   {
+                   case MULTIBOOT_FRAMEBUFFER_TYPE_INDEXED:
+                     {
+                       unsigned best_distance, distance;
+                       struct multiboot_color *palette;
+     
+                       palette = tagfb-&gt;framebuffer_palette;
+     
+                       color = 0;
+                       best_distance = 4*256*256;
+     
+                       for (i = 0; i &lt; tagfb-&gt;framebuffer_palette_num_colors; i++)
+                         {
+                           distance = (0xff - palette[i].blue)
+                             * (0xff - palette[i].blue)
+                             + palette[i].red * palette[i].red
+                             + palette[i].green * palette[i].green;
+                           if (distance &lt; best_distance)
+                             {
+                               color = i;
+                               best_distance = distance;
+                             }
+                         }
+                     }
+                     break;
+     
+                   case MULTIBOOT_FRAMEBUFFER_TYPE_RGB:
+                     color = ((1 &lt;&lt; tagfb-&gt;framebuffer_blue_mask_size) - 1)
+                       &lt;&lt; tagfb-&gt;framebuffer_blue_field_position;
+                     break;
+     
+                   case MULTIBOOT_FRAMEBUFFER_TYPE_EGA_TEXT:
+                     color = '\\' | 0x0100;
+                     break;
+     
+                   default:
+                     color = 0xffffffff;
+                     break;
+                   }
+     
+                 for (i = 0; i &lt; tagfb-&gt;common.framebuffer_width
+                        &amp;&amp; i &lt; tagfb-&gt;common.framebuffer_height; i++)
+                   {
+                     switch (tagfb-&gt;common.framebuffer_bpp)
+                       {
+                       case 8:
+                         {
+                           multiboot_uint8_t *pixel = fb
+                             + tagfb-&gt;common.framebuffer_pitch * i + i;
+                           *pixel = color;
+                         }
+                         break;
+                       case 15:
+                       case 16:
+                         {
+                           multiboot_uint16_t *pixel
+                             = fb + tagfb-&gt;common.framebuffer_pitch * i + 2 * i;
+                           *pixel = color;
+                         }
+                         break;
+                       case 24:
+                         {
+                           multiboot_uint32_t *pixel
+                             = fb + tagfb-&gt;common.framebuffer_pitch * i + 3 * i;
+                           *pixel = (color &amp; 0xffffff) | (*pixel &amp; 0xff000000);
+                         }
+                         break;
+     
+                       case 32:
+                         {
+                           multiboot_uint32_t *pixel
+                             = fb + tagfb-&gt;common.framebuffer_pitch * i + 4 * i;
+                           *pixel = color;
+                         }
+                         break;
+                       }
+                   }
+                 break;
+               }
+     
+             }
+         }
+       tag = (struct multiboot_tag *) ((multiboot_uint8_t *) tag
+                                       + ((tag-&gt;size + 7) &amp; ~7));
+       printf ("Total mbi size 0x%x\n", (unsigned) tag - addr);
+     }
+     
+     /* <span class="roman"> Clear the screen and initialize VIDEO, XPOS and YPOS.</span> */
+     static void
+     cls (void)
+     {
+       int i;
+     
+       video = (unsigned char *) VIDEO;
+     
+       for (i = 0; i &lt; COLUMNS * LINES * 2; i++)
+         *(video + i) = 0;
+     
+       xpos = 0;
+       ypos = 0;
+     }
+     
+     /* <span class="roman"> Convert the integer D to a string and save the string in BUF. If
+        BASE is equal to 'd', interpret that D is decimal, and if BASE is
+        equal to 'x', interpret that D is hexadecimal.</span> */
+     static void
+     itoa (char *buf, int base, int d)
+     {
+       char *p = buf;
+       char *p1, *p2;
+       unsigned long ud = d;
+       int divisor = 10;
+     
+       /* <span class="roman"> If %d is specified and D is minus, put `-' in the head.</span> */
+       if (base == 'd' &amp;&amp; d &lt; 0)
+         {
+           *p++ = '-';
+           buf++;
+           ud = -d;
+         }
+       else if (base == 'x')
+         divisor = 16;
+     
+       /* <span class="roman"> Divide UD by DIVISOR until UD == 0.</span> */
+       do
+         {
+           int remainder = ud % divisor;
+     
+           *p++ = (remainder &lt; 10) ? remainder + '0' : remainder + 'a' - 10;
+         }
+       while (ud /= divisor);
+     
+       /* <span class="roman"> Terminate BUF.</span> */
+       *p = 0;
+     
+       /* <span class="roman"> Reverse BUF.</span> */
+       p1 = buf;
+       p2 = p - 1;
+       while (p1 &lt; p2)
+         {
+           char tmp = *p1;
+           *p1 = *p2;
+           *p2 = tmp;
+           p1++;
+           p2--;
+         }
+     }
+     
+     /* <span class="roman"> Put the character C on the screen.</span> */
+     static void
+     putchar (int c)
+     {
+       if (c == '\n' || c == '\r')
+         {
+         newline:
+           xpos = 0;
+           ypos++;
+           if (ypos &gt;= LINES)
+             ypos = 0;
+           return;
+         }
+     
+       *(video + (xpos + ypos * COLUMNS) * 2) = c &amp; 0xFF;
+       *(video + (xpos + ypos * COLUMNS) * 2 + 1) = ATTRIBUTE;
+     
+       xpos++;
+       if (xpos &gt;= COLUMNS)
+         goto newline;
+     }
+     
+     /* <span class="roman"> Format a string and print it on the screen, just like the libc
+        function printf.</span> */
+     void
+     printf (const char *format, ...)
+     {
+       char **arg = (char **) &amp;format;
+       int c;
+       char buf[20];
+     
+       arg++;
+     
+       while ((c = *format++) != 0)
+         {
+           if (c != '%')
+             putchar (c);
+           else
+             {
+               char *p, *p2;
+               int pad0 = 0, pad = 0;
+     
+               c = *format++;
+               if (c == '0')
+                 {
+                   pad0 = 1;
+                   c = *format++;
+                 }
+     
+               if (c &gt;= '0' &amp;&amp; c &lt;= '9')
+                 {
+                   pad = c - '0';
+                   c = *format++;
+                 }
+     
+               switch (c)
+                 {
+                 case 'd':
+                 case 'u':
+                 case 'x':
+                   itoa (buf, c, *((int *) arg++));
+                   p = buf;
+                   goto string;
+                   break;
+     
+                 case 's':
+                   p = *arg++;
+                   if (! p)
+                     p = "(null)";
+     
+                 string:
+                   for (p2 = p; *p2; p2++);
+                   for (; p2 &lt; p + pad; p2++)
+                     putchar (pad0 ? '0' : ' ');
+                   while (*p)
+                     putchar (*p++);
+                   break;
+     
+                 default:
+                   putchar (*((int *) arg++));
+                   break;
+                 }
+             }
+         }
+     }
+</pre>
+   <div class="node">
+<a name="Other-Multiboot2-kernels"></a>
+<p><hr>
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#kernel_002ec">kernel.c</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Example-OS-code">Example OS code</a>
+
+</div>
+
+<h4 class="subsection">4.4.4 Other Multiboot2 kernels</h4>
+
+<p>Other useful information should be available in Multiboot2 kernels, such
+as GNU Mach and Fiasco <a href="http://os.inf.tu-dresden.de/fiasco/">http://os.inf.tu-dresden.de/fiasco/</a>. And,
+it is worth mentioning the OSKit
+<a href="http://www.cs.utah.edu/projects/flux/oskit/">http://www.cs.utah.edu/projects/flux/oskit/</a>, which provides a
+library supporting the specification.
+
+<div class="node">
+<a name="Example-boot-loader-code"></a>
+<p><hr>
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Example-OS-code">Example OS code</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Examples">Examples</a>
+
+</div>
+
+<h3 class="section">4.5 Example boot loader code</h3>
+
+<p>The GNU GRUB (see <a href="grub.html#Top">GRUB</a>) project
+is a Multiboot2-compliant boot loader, supporting all required and
+many optional features present in this specification. A public release has
+not been made, but the test release is available from:
+
+   <p><a href="ftp://alpha.gnu.org/gnu/grub">ftp://alpha.gnu.org/gnu/grub</a>
+
+   <p>See the webpage <a href="http://www.gnu.org/software/grub/grub.html">http://www.gnu.org/software/grub/grub.html</a>, for
+more information.
+
+<div class="node">
+<a name="History"></a>
+<p><hr>
+Next:&nbsp;<a rel="next" accesskey="n" href="#Index">Index</a>,
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#Examples">Examples</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>
+
+</div>
+
+<h2 class="chapter">5 The change log of this specification</h2>
+
+     <dl>
+<dt>0.7<dd>
+          <ul>
+<li><dfn>Multiboot2 Standard</dfn> is renamed to <dfn>Multiboot2 Specification</dfn>.
+
+          <li>Graphics fields are added to Multiboot2 header.
+
+          <li>BIOS drive information, BIOS configuration table, the name of a boot
+loader, APM information, and graphics information are added to Multiboot2
+information.
+
+          <li>Rewritten in Texinfo format.
+
+          <li>Rewritten, using more strict words.
+
+          <li>The maintainer changes to the GNU GRUB maintainer team
+<a href="mailto:bug-grub@gnu.org">bug-grub@gnu.org</a>, from Bryan Ford and Erich Stefan Boleyn.
+
+          <li>The byte order of the &lsquo;<samp><span class="samp">boot_device</span></samp>&rsquo; in Multiboot2 information is
+reversed. This was a mistake.
+
+          <li>The offset of the address fields were wrong.
+
+          <li>The format is adapted to a newer Texinfo, and the version number is
+specified more explicitly in the title. 
+</ul>
+
+     <br><dt>0.6<dd>
+          <ul>
+<li>A few wording changes.
+
+          <li>Header checksum.
+
+          <li>Classification of machine state passed to an operating system. 
+</ul>
+
+     <br><dt>0.5<dd>
+          <ul>
+<li>Name change. 
+</ul>
+
+     <br><dt>0.4<dd>
+          <ul>
+<li>Major changes plus HTMLification. 
+</ul>
+     </dl>
+
+<div class="node">
+<a name="Index"></a>
+<p><hr>
+Previous:&nbsp;<a rel="previous" accesskey="p" href="#History">History</a>,
+Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>
+
+</div>
+
+<h2 class="unnumbered">Index</h2>
+
+<ul class="index-cp" compact>
+</ul>
+<div class="contents">
+<h2>Table of Contents</h2>
+<ul>
+<li><a name="toc_Top" href="#Top">Multiboot2 Specification</a>
+<li><a name="toc_Overview" href="#Overview">1 Introduction to Multiboot2 Specification</a>
+<ul>
+<li><a href="#Motivation">1.1 The background of Multiboot2 Specification</a>
+<li><a href="#Architecture">1.2 The target architecture</a>
+<li><a href="#Operating-systems">1.3 The target operating systems</a>
+<li><a href="#Boot-sources">1.4 Boot sources</a>
+<li><a href="#Boot_002dtime-configuration">1.5 Configure an operating system at boot-time</a>
+<li><a href="#Convenience-to-operating-systems">1.6 How to make OS development easier</a>
+<li><a href="#Boot-modules">1.7 Boot modules</a>
+</li></ul>
+<li><a name="toc_Terminology" href="#Terminology">2 The definitions of terms used through the specification</a>
+<li><a name="toc_Specification" href="#Specification">3 The exact definitions of Multiboot2 Specification</a>
+<ul>
+<li><a href="#OS-image-format">3.1 OS image format</a>
+<ul>
+<li><a href="#Header-layout">3.1.1 The layout of Multiboot2 header</a>
+<li><a href="#Header-magic-fields">3.1.2 The magic fields of Multiboot2 header</a>
+<li><a href="#Header-tags">3.1.3 General tag structure</a>
+<li><a href="#Information-request-header-tag">3.1.4 Multiboot2 information request</a>
+<li><a href="#Address-header-tag">3.1.5 The address tag of Multiboot2 header</a>
+<li><a href="#Address-header-tag">3.1.6 The entry address tag of Multiboot2 header</a>
+<li><a href="#Address-header-tag">3.1.7 EFI i386 entry address tag of Multiboot2 header</a>
+<li><a href="#Address-header-tag">3.1.8 EFI amd64 entry address tag of Multiboot2 header</a>
+<li><a href="#Console-header-tags">3.1.9 Flags tag</a>
+<li><a href="#Console-header-tags">3.1.10 The framebuffer tag of Multiboot2 header</a>
+<li><a href="#Module-alignment-tag">3.1.11 Module alignment tag</a>
+<li><a href="#EFI-boot-services-tag">3.1.12 EFI boot services tag</a>
+<li><a href="#Relocatable-header-tag">3.1.13 Relocatable header tag</a>
+</li></ul>
+<li><a href="#Machine-state">3.2 MIPS machine state</a>
+<li><a href="#Machine-state">3.3 I386 machine state</a>
+<li><a href="#Machine-state">3.4 EFI i386 machine state with boot services enabled</a>
+<li><a href="#Machine-state">3.5 EFI amd64 machine state with boot services enabled</a>
+<li><a href="#Boot-information-format">3.6 Boot information</a>
+<ul>
+<li><a href="#Boot-information-format">3.6.1 Boot information format</a>
+<li><a href="#Boot-information-format">3.6.2 Basic tags structure</a>
+<li><a href="#Boot-information-format">3.6.3 Basic memory information</a>
+<li><a href="#Boot-information-format">3.6.4 BIOS Boot device</a>
+<li><a href="#Boot-information-format">3.6.5 Boot command line</a>
+<li><a href="#Boot-information-format">3.6.6 Modules</a>
+<li><a href="#Boot-information-format">3.6.7 ELF-Symbols</a>
+<li><a href="#Boot-information-format">3.6.8 Memory map</a>
+<li><a href="#Boot-information-format">3.6.9 Boot loader name</a>
+<li><a href="#Boot-information-format">3.6.10 APM table</a>
+<li><a href="#Boot-information-format">3.6.11 VBE info</a>
+<li><a href="#Boot-information-format">3.6.12 Framebuffer info</a>
+<li><a href="#Boot-information-format">3.6.13 EFI 32-bit system table pointer</a>
+<li><a href="#Boot-information-format">3.6.14 EFI 64-bit system table pointer</a>
+<li><a href="#Boot-information-format">3.6.15 SMBIOS tables</a>
+<li><a href="#Boot-information-format">3.6.16 ACPI old RSDP</a>
+<li><a href="#Boot-information-format">3.6.17 ACPI new RSDP</a>
+<li><a href="#Boot-information-format">3.6.18 Networking information</a>
+<li><a href="#Boot-information-format">3.6.19 EFI memory map</a>
+<li><a href="#Boot-information-format">3.6.20 EFI boot services not terminated</a>
+<li><a href="#Boot-information-format">3.6.21 EFI 32-bit image handle pointer</a>
+<li><a href="#Boot-information-format">3.6.22 EFI 64-bit image handle pointer</a>
+<li><a href="#Boot-information-format">3.6.23 Image load base physical address</a>
+</li></ul>
+</li></ul>
+<li><a name="toc_Examples" href="#Examples">4 Examples</a>
+<ul>
+<li><a href="#C-structure-members-alignment-and-padding-consideration">4.1 C structure members alignment and padding consideration</a>
+<li><a href="#Notes-on-PC">4.2 Notes on PC</a>
+<li><a href="#BIOS-device-mapping-techniques">4.3 BIOS device mapping techniques</a>
+<ul>
+<li><a href="#Data-comparison-technique">4.3.1 Data comparison technique</a>
+<li><a href="#I_002fO-restriction-technique">4.3.2 I/O restriction technique</a>
+</li></ul>
+<li><a href="#Example-OS-code">4.4 Example OS code</a>
+<ul>
+<li><a href="#multiboot2_002eh">4.4.1 multiboot2.h</a>
+<li><a href="#boot_002eS">4.4.2 boot.S</a>
+<li><a href="#kernel_002ec">4.4.3 kernel.c</a>
+<li><a href="#Other-Multiboot2-kernels">4.4.4 Other Multiboot2 kernels</a>
+</li></ul>
+<li><a href="#Example-boot-loader-code">4.5 Example boot loader code</a>
+</li></ul>
+<li><a name="toc_History" href="#History">5 The change log of this specification</a>
+<li><a name="toc_Index" href="#Index">Index</a>
+</li></ul>
+</div>
+
+</body></html>
+
diff --git a/include/x86/multiboot2.h b/include/x86/multiboot2.h
new file mode 100644
index 0000000..5693923
--- /dev/null
+++ b/include/x86/multiboot2.h
@@ -0,0 +1,416 @@
+/*  multiboot2.h - Multiboot 2 header file.  */
+/*  Copyright (C) 1999,2003,2007,2008,2009,2010  Free Software Foundation, Inc.
+ *
+ *  Permission is hereby granted, free of charge, to any person obtaining a copy
+ *  of this software and associated documentation files (the "Software"), to
+ *  deal in the Software without restriction, including without limitation the
+ *  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ *  sell copies of the Software, and to permit persons to whom the Software is
+ *  furnished to do so, subject to the following conditions:
+ *
+ *  The above copyright notice and this permission notice shall be included in
+ *  all copies or substantial portions of the Software.
+ *
+ *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL ANY
+ *  DEVELOPER OR DISTRIBUTOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
+ *  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef MULTIBOOT_HEADER
+#define MULTIBOOT_HEADER 1
+
+/* How many bytes from the start of the file we search for the header.  */
+#define MULTIBOOT_SEARCH			32768
+#define MULTIBOOT_HEADER_ALIGN			8
+
+/* The magic field should contain this.  */
+#define MULTIBOOT2_HEADER_MAGIC			0xe85250d6
+
+/* This should be in %eax.  */
+#define MULTIBOOT2_BOOTLOADER_MAGIC		0x36d76289
+
+/* Alignment of multiboot modules.  */
+#define MULTIBOOT_MOD_ALIGN			0x00001000
+
+/* Alignment of the multiboot info structure.  */
+#define MULTIBOOT_INFO_ALIGN			0x00000008
+
+/* Flags set in the 'flags' member of the multiboot header.  */
+
+#define MULTIBOOT_TAG_ALIGN                  8
+#define MULTIBOOT_TAG_TYPE_END               0
+#define MULTIBOOT_TAG_TYPE_CMDLINE           1
+#define MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME  2
+#define MULTIBOOT_TAG_TYPE_MODULE            3
+#define MULTIBOOT_TAG_TYPE_BASIC_MEMINFO     4
+#define MULTIBOOT_TAG_TYPE_BOOTDEV           5
+#define MULTIBOOT_TAG_TYPE_MMAP              6
+#define MULTIBOOT_TAG_TYPE_VBE               7
+#define MULTIBOOT_TAG_TYPE_FRAMEBUFFER       8
+#define MULTIBOOT_TAG_TYPE_ELF_SECTIONS      9
+#define MULTIBOOT_TAG_TYPE_APM               10
+#define MULTIBOOT_TAG_TYPE_EFI32             11
+#define MULTIBOOT_TAG_TYPE_EFI64             12
+#define MULTIBOOT_TAG_TYPE_SMBIOS            13
+#define MULTIBOOT_TAG_TYPE_ACPI_OLD          14
+#define MULTIBOOT_TAG_TYPE_ACPI_NEW          15
+#define MULTIBOOT_TAG_TYPE_NETWORK           16
+#define MULTIBOOT_TAG_TYPE_EFI_MMAP          17
+#define MULTIBOOT_TAG_TYPE_EFI_BS            18
+#define MULTIBOOT_TAG_TYPE_EFI32_IH          19
+#define MULTIBOOT_TAG_TYPE_EFI64_IH          20
+#define MULTIBOOT_TAG_TYPE_LOAD_BASE_ADDR    21
+
+#define MULTIBOOT_HEADER_TAG_END  0
+#define MULTIBOOT_HEADER_TAG_INFORMATION_REQUEST  1
+#define MULTIBOOT_HEADER_TAG_ADDRESS  2
+#define MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS  3
+#define MULTIBOOT_HEADER_TAG_CONSOLE_FLAGS  4
+#define MULTIBOOT_HEADER_TAG_FRAMEBUFFER  5
+#define MULTIBOOT_HEADER_TAG_MODULE_ALIGN  6
+#define MULTIBOOT_HEADER_TAG_EFI_BS  7
+#define MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS_EFI64  9
+#define MULTIBOOT_HEADER_TAG_RELOCATABLE  10
+
+#define MULTIBOOT2_ARCHITECTURE_I386  0
+#define MULTIBOOT2_ARCHITECTURE_MIPS32  4
+#define MULTIBOOT_HEADER_TAG_OPTIONAL 1
+
+#define MULTIBOOT_LOAD_PREFERENCE_NONE 0
+#define MULTIBOOT_LOAD_PREFERENCE_LOW 1
+#define MULTIBOOT_LOAD_PREFERENCE_HIGH 2
+
+#define MULTIBOOT_CONSOLE_FLAGS_CONSOLE_REQUIRED 1
+#define MULTIBOOT_CONSOLE_FLAGS_EGA_TEXT_SUPPORTED 2
+
+#ifndef ASM_FILE
+
+typedef unsigned char		multiboot_uint8_t;
+typedef unsigned short		multiboot_uint16_t;
+typedef unsigned int		multiboot_uint32_t;
+typedef unsigned long long	multiboot_uint64_t;
+
+struct multiboot_header
+{
+  /* Must be MULTIBOOT_MAGIC - see above.  */
+  multiboot_uint32_t magic;
+
+  /* ISA */
+  multiboot_uint32_t architecture;
+
+  /* Total header length.  */
+  multiboot_uint32_t header_length;
+
+  /* The above fields plus this one must equal 0 mod 2^32. */
+  multiboot_uint32_t checksum;
+};
+
+struct multiboot_header_tag
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+};
+
+struct multiboot_header_tag_information_request
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+  multiboot_uint32_t requests[0];
+};
+
+struct multiboot_header_tag_address
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+  multiboot_uint32_t header_addr;
+  multiboot_uint32_t load_addr;
+  multiboot_uint32_t load_end_addr;
+  multiboot_uint32_t bss_end_addr;
+};
+
+struct multiboot_header_tag_entry_address
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+  multiboot_uint32_t entry_addr;
+};
+
+struct multiboot_header_tag_console_flags
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+  multiboot_uint32_t console_flags;
+};
+
+struct multiboot_header_tag_framebuffer
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+  multiboot_uint32_t width;
+  multiboot_uint32_t height;
+  multiboot_uint32_t depth;
+};
+
+struct multiboot_header_tag_module_align
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+};
+
+struct multiboot_header_tag_relocatable
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+  multiboot_uint32_t min_addr;
+  multiboot_uint32_t max_addr;
+  multiboot_uint32_t align;
+  multiboot_uint32_t preference;
+};
+
+struct multiboot_color
+{
+  multiboot_uint8_t red;
+  multiboot_uint8_t green;
+  multiboot_uint8_t blue;
+};
+
+struct multiboot_mmap_entry
+{
+  multiboot_uint64_t addr;
+  multiboot_uint64_t len;
+#define MULTIBOOT_MEMORY_AVAILABLE		1
+#define MULTIBOOT_MEMORY_RESERVED		2
+#define MULTIBOOT_MEMORY_ACPI_RECLAIMABLE       3
+#define MULTIBOOT_MEMORY_NVS                    4
+#define MULTIBOOT_MEMORY_BADRAM                 5
+  multiboot_uint32_t type;
+  multiboot_uint32_t zero;
+};
+typedef struct multiboot_mmap_entry multiboot_memory_map_t;
+
+struct multiboot_tag
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+};
+
+struct multiboot_tag_string
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  char string[0];
+};
+
+struct multiboot_tag_module
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t mod_start;
+  multiboot_uint32_t mod_end;
+  char cmdline[0];
+};
+
+struct multiboot_tag_basic_meminfo
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t mem_lower;
+  multiboot_uint32_t mem_upper;
+};
+
+struct multiboot_tag_bootdev
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t biosdev;
+  multiboot_uint32_t slice;
+  multiboot_uint32_t part;
+};
+
+struct multiboot_tag_mmap
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t entry_size;
+  multiboot_uint32_t entry_version;
+  struct multiboot_mmap_entry entries[0];  
+};
+
+struct multiboot_vbe_info_block
+{
+  multiboot_uint8_t external_specification[512];
+};
+
+struct multiboot_vbe_mode_info_block
+{
+  multiboot_uint8_t external_specification[256];
+};
+
+struct multiboot_tag_vbe
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+
+  multiboot_uint16_t vbe_mode;
+  multiboot_uint16_t vbe_interface_seg;
+  multiboot_uint16_t vbe_interface_off;
+  multiboot_uint16_t vbe_interface_len;
+
+  struct multiboot_vbe_info_block vbe_control_info;
+  struct multiboot_vbe_mode_info_block vbe_mode_info;
+};
+
+struct multiboot_tag_framebuffer_common
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+
+  multiboot_uint64_t framebuffer_addr;
+  multiboot_uint32_t framebuffer_pitch;
+  multiboot_uint32_t framebuffer_width;
+  multiboot_uint32_t framebuffer_height;
+  multiboot_uint8_t framebuffer_bpp;
+#define MULTIBOOT_FRAMEBUFFER_TYPE_INDEXED 0
+#define MULTIBOOT_FRAMEBUFFER_TYPE_RGB     1
+#define MULTIBOOT_FRAMEBUFFER_TYPE_EGA_TEXT	2
+  multiboot_uint8_t framebuffer_type;
+  multiboot_uint16_t reserved;
+};
+
+struct multiboot_tag_framebuffer
+{
+  struct multiboot_tag_framebuffer_common common;
+
+  union
+  {
+    struct
+    {
+      multiboot_uint16_t framebuffer_palette_num_colors;
+      struct multiboot_color framebuffer_palette[0];
+    };
+    struct
+    {
+      multiboot_uint8_t framebuffer_red_field_position;
+      multiboot_uint8_t framebuffer_red_mask_size;
+      multiboot_uint8_t framebuffer_green_field_position;
+      multiboot_uint8_t framebuffer_green_mask_size;
+      multiboot_uint8_t framebuffer_blue_field_position;
+      multiboot_uint8_t framebuffer_blue_mask_size;
+    };
+  };
+};
+
+struct multiboot_tag_elf_sections
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t num;
+  multiboot_uint32_t entsize;
+  multiboot_uint32_t shndx;
+  char sections[0];
+};
+
+struct multiboot_tag_apm
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint16_t version;
+  multiboot_uint16_t cseg;
+  multiboot_uint32_t offset;
+  multiboot_uint16_t cseg_16;
+  multiboot_uint16_t dseg;
+  multiboot_uint16_t flags;
+  multiboot_uint16_t cseg_len;
+  multiboot_uint16_t cseg_16_len;
+  multiboot_uint16_t dseg_len;
+};
+
+struct multiboot_tag_efi32
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t pointer;
+};
+
+struct multiboot_tag_efi64
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint64_t pointer;
+};
+
+struct multiboot_tag_smbios
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint8_t major;
+  multiboot_uint8_t minor;
+  multiboot_uint8_t reserved[6];
+  multiboot_uint8_t tables[0];
+};
+
+struct multiboot_tag_old_acpi
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint8_t rsdp[0];
+};
+
+struct multiboot_tag_new_acpi
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint8_t rsdp[0];
+};
+
+struct multiboot_tag_network
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint8_t dhcpack[0];
+};
+
+struct multiboot_tag_efi_mmap
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t descr_size;
+  multiboot_uint32_t descr_vers;
+  multiboot_uint8_t efi_mmap[0];
+}; 
+
+struct multiboot_tag_efi32_ih
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t pointer;
+};
+
+struct multiboot_tag_efi64_ih
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint64_t pointer;
+};
+
+struct multiboot_tag_load_base_addr
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t load_base_addr;
+};
+
+#endif /* ! ASM_FILE */
+
+#endif /* ! MULTIBOOT_HEADER */
diff --git a/kexec/arch/i386/kexec-mb2-x86.c b/kexec/arch/i386/kexec-mb2-x86.c
new file mode 100644
index 0000000..7eaab0c
--- /dev/null
+++ b/kexec/arch/i386/kexec-mb2-x86.c
@@ -0,0 +1,543 @@
+/*
+ *  kexec-mb2-x86.c
+ *
+ *  multiboot2 support for kexec to boot xen.
+ *
+ *  Copyright (C) 2019 Varad Gautam (vrd at amazon.de), Amazon.com, Inc. or its affiliates.
+ *
+ *  Parts based on GNU GRUB, Copyright (C) 2000  Free Software Foundation, Inc
+ *  Parts taken from kexec-multiboot-x86.c, Eric Biederman (ebiederm@xmission.com)
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License as
+ *  published by the Free Software Foundation; either version 2 of the
+ *  License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ *  02111-1307, USA.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <elf.h>
+#include <boot/elf_boot.h>
+#include <ip_checksum.h>
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+#include "kexec-x86.h"
+#include <arch/options.h>
+
+/* From GNU GRUB */
+#include <x86/multiboot2.h>
+#include <x86/mb_info.h>
+
+/* Framebuffer */
+#include <sys/ioctl.h>
+#include <linux/fb.h>
+
+extern struct arch_options_t arch_options;
+
+/* Static storage */
+static char headerbuf[MULTIBOOT_SEARCH];
+static struct multiboot_header *mbh = NULL;
+struct multiboot2_header_info {
+	struct multiboot_header_tag_information_request *request_tag;
+	struct multiboot_header_tag_address *addr_tag;
+	struct multiboot_header_tag_entry_address *entry_addr_tag;
+	struct multiboot_header_tag_console_flags *console_tag;
+	struct multiboot_header_tag_framebuffer *fb_tag;
+	struct multiboot_header_tag_module_align *mod_align_tag;
+	struct multiboot_header_tag_relocatable *rel_tag;
+} mhi;
+
+#define ALIGN_UP(addr, align) \
+	((addr + (typeof (addr)) align - 1) & ~((typeof (addr)) align - 1))
+
+int multiboot2_x86_probe(const char *buf, off_t buf_len)
+/* Is it a good idea to try booting this file? */
+{
+	int i, len;
+	/* First of all, check that this is an ELF file */
+	if ((i=elf_x86_probe(buf, buf_len)) < 0)
+		return i;
+
+	/* Now look for a multiboot header. */
+	len = MULTIBOOT_SEARCH;
+	if (len > buf_len)
+		len = buf_len;
+
+	memcpy(headerbuf, buf, len);
+	if (len < sizeof(struct multiboot_header)) {
+		/* Short file */
+		return -1;
+	}
+	for (mbh = (struct multiboot_header *) headerbuf;
+	     ((char *) mbh <= (char *) headerbuf + len - sizeof(struct multiboot_header));
+	     mbh = (struct multiboot_header *) ((char *) mbh + MULTIBOOT_HEADER_ALIGN)) {
+		if (mbh->magic == MULTIBOOT2_HEADER_MAGIC
+		    && !((mbh->magic+mbh->architecture+mbh->header_length+mbh->checksum) & 0xffffffff)) {
+			/* Found multiboot header. */
+			return 0;
+		}
+	}
+	/* Not multiboot */
+	return -1;
+}
+
+void multiboot2_x86_usage(void)
+/* Multiboot-specific options */
+{
+	printf("    --command-line=STRING        Set the kernel command line to STRING.\n");
+	printf("    --reuse-cmdline       	 Use kernel command line from running system.\n");
+	printf("    --module=\"MOD arg1 arg2...\"  Load module MOD with command-line \"arg1...\"\n");
+	printf("                                 (can be used multiple times).\n");
+}
+
+static size_t
+multiboot2_get_mbi_size(int ranges, int cmdline_size, int modcount, int modcmd_size)
+{
+	return (2 * sizeof (uint32_t) + sizeof (struct multiboot_tag)
+		+ sizeof (struct multiboot_tag)
+		+ ALIGN_UP (sizeof (struct multiboot_tag_basic_meminfo), MULTIBOOT_TAG_ALIGN)
+		+ ALIGN_UP ((sizeof (struct multiboot_tag_mmap)
+			+ ranges * sizeof (struct multiboot_mmap_entry)), MULTIBOOT_TAG_ALIGN)
+		+ ALIGN_UP (sizeof (struct multiboot_tag_load_base_addr), MULTIBOOT_TAG_ALIGN)
+		+ (sizeof (struct multiboot_tag_string)
+			+ ALIGN_UP (cmdline_size, MULTIBOOT_TAG_ALIGN))
+		+ (sizeof (struct multiboot_tag_string)
+			+ ALIGN_UP (strlen(BOOTLOADER " " BOOTLOADER_VERSION) + 1, MULTIBOOT_TAG_ALIGN))
+		+ (modcount * sizeof (struct multiboot_tag_module) + modcmd_size));
+}
+
+static void multiboot2_read_header_tags(void)
+{
+	struct multiboot_header_tag *tag;
+
+	for (tag = (struct multiboot_header_tag *) (mbh + 1);
+	     tag->type != MULTIBOOT_TAG_TYPE_END;
+	     tag = (struct multiboot_header_tag *) ((char *) tag + ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN)))
+	{
+		switch (tag->type)
+		{
+		case MULTIBOOT_HEADER_TAG_INFORMATION_REQUEST:
+		{
+			mhi.request_tag = (struct multiboot_header_tag_information_request *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_RELOCATABLE:
+		{
+			mhi.rel_tag = (struct multiboot_header_tag_relocatable *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_ADDRESS:
+		{
+			mhi.addr_tag = (struct multiboot_header_tag_address *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS:
+		{
+			mhi.entry_addr_tag = (struct multiboot_header_tag_entry_address *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_CONSOLE_FLAGS:
+		{
+			mhi.console_tag = (struct multiboot_header_tag_console_flags *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_FRAMEBUFFER:
+		{
+			mhi.fb_tag = (struct multiboot_header_tag_framebuffer *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_MODULE_ALIGN:
+		{
+			mhi.mod_align_tag = (struct multiboot_header_tag_module_align *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS_EFI64:
+		case MULTIBOOT_HEADER_TAG_EFI_BS:
+			/* Ignoring EFI. */
+			break;
+		default:
+		{
+			if (!(tag->flags & MULTIBOOT_HEADER_TAG_OPTIONAL))
+				fprintf(stderr, "unsupported tag: 0x%x", tag->type);
+			break;
+		}
+		}
+	}
+}
+
+struct multiboot_mmap_entry *multiboot_construct_memory_map(struct memory_range *range,
+							    int ranges,
+							    unsigned long long *mem_lower,
+							    unsigned long long *mem_upper)
+{
+	struct multiboot_mmap_entry *entries;
+	int i;
+
+	*mem_lower = *mem_upper = 0;
+	entries = xmalloc(ranges * sizeof(*entries));
+	for (i = 0; i < ranges; i++) {
+		entries[i].addr = range[i].start;
+		entries[i].len = range[i].end - range[i].start + 1;
+
+		if (range[i].type == RANGE_RAM) {
+			entries[i].type = MULTIBOOT_MEMORY_AVAILABLE;
+			/*
+			 * Is this the "low" memory?  Can't just test
+			 * against zero, because Linux protects (and
+			 * hides) the first few pages of physical
+			 * memory.
+			 */
+
+			if ((range[i].start <= 64*1024)
+				&& (range[i].end > *mem_lower)) {
+				range[i].start = 0;
+				*mem_lower = range[i].end;
+			}
+			/* Is this the "high" memory? */
+			if ((range[i].start <= 0x100000)
+				&& (range[i].end > *mem_upper + 0x100000))
+			*mem_upper = range[i].end - 0x100000;
+		} else if (range[i].type == RANGE_ACPI)
+			entries[i].type = MULTIBOOT_MEMORY_ACPI_RECLAIMABLE;
+		else if (range[i].type == RANGE_ACPI_NVS)
+			entries[i].type = MULTIBOOT_MEMORY_NVS;
+		else if (range[i].type == RANGE_RESERVED)
+			entries[i].type = MULTIBOOT_MEMORY_RESERVED;
+	}
+	return entries;
+}
+
+static uint64_t multiboot2_make_mbi(struct kexec_info *info, char *cmdline, int cmdline_len,
+			     unsigned long load_base_addr, void *mbi_buf, size_t mbi_bytes)
+{
+	uint64_t *ptrorig = mbi_buf;
+	struct multiboot_mmap_entry *mmap_entries;
+	unsigned long long mem_lower = 0, mem_upper = 0;
+
+	*ptrorig = mbi_bytes; /* u32 total_size, u32 reserved */
+	ptrorig++;
+
+	mmap_entries = multiboot_construct_memory_map(info->memory_range, info->memory_ranges, &mem_lower, &mem_upper);
+	{
+		struct multiboot_tag_basic_meminfo *tag = (struct multiboot_tag_basic_meminfo *) ptrorig;
+
+		tag->type = MULTIBOOT_TAG_TYPE_BASIC_MEMINFO;
+		tag->size = sizeof (struct multiboot_tag_basic_meminfo);
+		tag->mem_lower = mem_lower;
+		tag->mem_upper = mem_upper;
+		ptrorig += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+	}
+
+	{
+		struct multiboot_tag_mmap *tag = (struct multiboot_tag_mmap *) ptrorig;
+
+		tag->type = MULTIBOOT_TAG_TYPE_MMAP;
+		tag->size = sizeof(struct multiboot_tag_mmap) + sizeof(struct multiboot_mmap_entry) * info->memory_ranges;
+		tag->entry_size = sizeof(struct multiboot_mmap_entry);
+		tag->entry_version = 0;
+		memcpy(tag->entries, mmap_entries, tag->entry_size * info->memory_ranges);
+		ptrorig += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+	}
+
+	if (mhi.rel_tag) {
+		struct multiboot_tag_load_base_addr *tag = (struct multiboot_tag_load_base_addr *) ptrorig;
+
+		tag->type = MULTIBOOT_TAG_TYPE_LOAD_BASE_ADDR;
+		tag->size = sizeof (struct multiboot_tag_load_base_addr);
+		tag->load_base_addr = load_base_addr;
+		ptrorig += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+	}
+
+	{
+		struct multiboot_tag_string *tag = (struct multiboot_tag_string *) ptrorig;
+
+		tag->type = MULTIBOOT_TAG_TYPE_CMDLINE;
+		tag->size = sizeof (struct multiboot_tag_string) + cmdline_len;
+		memcpy(tag->string, cmdline, cmdline_len);
+		ptrorig += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+	}
+
+	{
+		struct multiboot_tag_string *tag = (struct multiboot_tag_string *) ptrorig;
+
+		tag->type = MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME;
+		tag->size = sizeof(struct multiboot_tag_string) + strlen(BOOTLOADER " " BOOTLOADER_VERSION) + 1;
+		sprintf(tag->string, "%s", BOOTLOADER " " BOOTLOADER_VERSION);
+		ptrorig += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+	}
+
+	if (mhi.fb_tag) {
+		struct multiboot_tag_framebuffer *tag = (struct multiboot_tag_framebuffer *) ptrorig;
+		struct fb_fix_screeninfo info;
+		struct fb_var_screeninfo mode;
+		int fd;
+
+		tag->common.type = MULTIBOOT_TAG_TYPE_FRAMEBUFFER;
+		tag->common.size = sizeof(struct multiboot_tag_framebuffer);
+		/* check if purgatory will reset to standard ega text mode */
+		if (arch_options.reset_vga || arch_options.console_vga) {
+			tag->common.framebuffer_type = MB_FRAMEBUFFER_TYPE_EGA_TEXT;
+			tag->common.framebuffer_addr = 0xb8000;
+			tag->common.framebuffer_pitch = 80*2;
+			tag->common.framebuffer_width = 80;
+			tag->common.framebuffer_height = 25;
+			tag->common.framebuffer_bpp = 16;
+
+			ptrorig += ALIGN_UP (tag->common.size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+			goto out;
+		}
+
+		/* use current graphics framebuffer settings */
+		fd = open("/dev/fb0", O_RDONLY);
+		if (fd < 0) {
+			fprintf(stderr, "can't open /dev/fb0: %s\n", strerror(errno));
+			goto out;
+		}
+		if (ioctl(fd, FBIOGET_FSCREENINFO, &info) < 0){
+			fprintf(stderr, "can't get screeninfo: %s\n", strerror(errno));
+			close(fd);
+			goto out;
+		}
+		if (ioctl(fd, FBIOGET_VSCREENINFO, &mode) < 0){
+			fprintf(stderr, "can't get modeinfo: %s\n", strerror(errno));
+			close(fd);
+			goto out;
+		}
+		close(fd);
+
+		if (info.smem_start == 0 || info.smem_len == 0) {
+			fprintf(stderr, "can't get linerar framebuffer address\n");
+			goto out;
+		}
+
+		if (info.type != FB_TYPE_PACKED_PIXELS) {
+			fprintf(stderr, "unsupported framebuffer type\n");
+			goto out;
+		}
+
+		if (info.visual != FB_VISUAL_TRUECOLOR) {
+			fprintf(stderr, "unsupported framebuffer visual\n");
+			goto out;
+		}
+
+		tag->common.framebuffer_type = MB_FRAMEBUFFER_TYPE_RGB;
+		tag->common.framebuffer_addr = info.smem_start;
+		tag->common.framebuffer_pitch = info.line_length;
+		tag->common.framebuffer_width = mode.xres;
+		tag->common.framebuffer_height = mode.yres;
+		tag->common.framebuffer_bpp = mode.bits_per_pixel;
+
+		tag->framebuffer_red_field_position = mode.red.offset;
+		tag->framebuffer_red_mask_size = mode.red.length;
+		tag->framebuffer_green_field_position = mode.green.offset;
+		tag->framebuffer_green_mask_size = mode.green.length;
+		tag->framebuffer_blue_field_position = mode.blue.offset;
+		tag->framebuffer_blue_mask_size = mode.blue.length;
+
+		ptrorig += ALIGN_UP (tag->common.size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+	}
+
+out:
+	return (uint64_t) ptrorig;
+}
+
+static uint64_t multiboot2_mbi_add_module(void *mbi_buf, uint64_t mbi_ptr, uint32_t mod_start,
+					  uint32_t mod_end, char *mod_clp)
+{
+	struct multiboot_tag_module *tag = (struct multiboot_tag_module *) mbi_ptr;
+
+	tag->type = MULTIBOOT_TAG_TYPE_MODULE;
+	tag->size = sizeof(struct multiboot_tag_module) + strlen((char *)(long) mod_clp) + 1;
+	tag->mod_start = mod_start;
+	tag->mod_end = mod_end;
+
+	memcpy(tag->cmdline, (char *)(long) mod_clp, strlen((char *)(long) mod_clp) + 1);
+	mbi_ptr += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN);
+
+	return mbi_ptr;
+}
+
+static uint64_t multiboot2_mbi_end(void *mbi_buf, uint64_t mbi_ptr)
+{
+	struct multiboot_tag *tag = (struct multiboot_tag *) mbi_ptr;
+
+	tag->type = MULTIBOOT_TAG_TYPE_END;
+	tag->size = sizeof (struct multiboot_tag);
+	mbi_ptr += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN);
+
+	return mbi_ptr;
+}
+
+int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
+			struct kexec_info *info)
+{
+	struct mem_ehdr ehdr;
+	void *mbi_buf;
+	size_t mbi_bytes;
+	unsigned long addr;
+	struct entry32_regs regs;
+	char *command_line = NULL, *tmp_cmdline = NULL;
+	int command_line_len;
+	char *imagename, *cp, *append = NULL;;
+	int result;
+	int opt;
+	int modules, mod_command_line_space;
+	uint64_t mbi_ptr;
+	char *mod_clp_base;
+	/* See options.h -- add any more there, too. */
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{ "command-line",		1, 0, OPT_CL },
+		{ "append",			1, 0, OPT_CL },
+		{ "reuse-cmdline",		0, 0, OPT_REUSE_CMDLINE },
+		{ "module",			1, 0, OPT_MOD },
+		{ 0, 				0, 0, 0 },
+	};
+	static const char short_options[] = KEXEC_ARCH_OPT_STR "";
+
+	/* Probe for the MB header if it's not already found */
+	if (mbh == NULL && multiboot_x86_probe(buf, len) != 1)
+	{
+		fprintf(stderr, "Cannot find a loadable multiboot2 header.\n");
+		return -1;
+	}
+
+	/* Parse the header tags. */
+	multiboot2_read_header_tags();
+
+	/* Parse the command line */
+	command_line_len = 0;
+	modules = 0;
+	mod_command_line_space = 0;
+	result = 0;
+	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1)
+	{
+		switch(opt) {
+		default:
+			/* Ignore core options */
+			if (opt < OPT_ARCH_MAX) {
+				break;
+			}
+		case OPT_CL:
+			append = optarg;
+			break;
+		case OPT_REUSE_CMDLINE:
+			tmp_cmdline = get_command_line();
+			break;
+		case OPT_MOD:
+			modules++;
+			mod_command_line_space += strlen(optarg) + 1;
+			break;
+		}
+	}
+	imagename = argv[optind];
+
+	/* Final command line = imagename + <OPT_REUSE_CMDLINE> + <OPT_CL> */
+	tmp_cmdline = concat_cmdline(command_line, append);
+	if (command_line) {
+		free(command_line);
+	}
+	command_line = concat_cmdline(imagename, tmp_cmdline);
+	if (tmp_cmdline) {
+		free(tmp_cmdline);
+	}
+	command_line_len = strlen(command_line) + 1;
+
+	/* Load the ELF executable */
+	if (mhi.rel_tag)
+		elf_exec_build_load_relocatable(info, &ehdr, buf, len, 0,
+						mhi.rel_tag->min_addr, mhi.rel_tag->max_addr,
+						mhi.rel_tag->align);
+	else
+		elf_exec_build_load(info, &ehdr, buf, len, 0);
+
+	/* Load the setup code */
+	elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
+			   0, ULONG_MAX, 1, 0);
+
+	/* Construct information tags. */
+	mbi_bytes = multiboot2_get_mbi_size(info->memory_ranges, command_line_len, modules, mod_command_line_space);
+	mbi_buf = xmalloc(mbi_bytes);
+
+	mbi_ptr = multiboot2_make_mbi(info, command_line, command_line_len, info->rhdr.rel_addr, mbi_buf, mbi_bytes);
+	free(command_line);
+
+	/* Load modules */
+	if (modules) {
+		char *mod_filename, *mod_command_line, *mod_clp, *buf;
+		off_t mod_size;
+		int i = 0;
+
+		mod_clp_base = xmalloc(mod_command_line_space);
+
+		/* Go back and parse the module command lines */
+		mod_clp = mod_clp_base;
+		optind = opterr = 1;
+		while((opt = getopt_long(argc, argv,
+					 short_options, options, 0)) != -1) {
+			if (opt != OPT_MOD) continue;
+
+			/* Split module filename from command line */
+			mod_command_line = mod_filename = optarg;
+			if ((cp = strchr(mod_filename, ' ')) != NULL) {
+				/* See as I discard the 'const' modifier */
+				*cp = '\0';
+			}
+
+			/* Load the module */
+			buf = slurp_decompress_file(mod_filename, &mod_size);
+
+			if (cp != NULL) *cp = ' ';
+
+			/* Pick the next aligned spot to load it in. Always page align. */
+			addr = add_buffer(info, buf, mod_size, mod_size, getpagesize(),
+					  mhi.rel_tag->min_addr, mhi.rel_tag->max_addr, 1);
+
+			/* Add the module command line */
+			sprintf(mod_clp, "%s", mod_command_line);
+
+			mbi_ptr = multiboot2_mbi_add_module(mbi_buf, mbi_ptr, addr, addr + mod_size, mod_clp);
+
+			mod_clp += strlen(mod_clp) + 1;
+			i++;
+		}
+
+		free(mod_clp_base);
+	}
+
+	mbi_ptr = multiboot2_mbi_end(mbi_buf, mbi_ptr);
+
+	if (sort_segments(info) < 0)
+		return -1;
+
+	addr = add_buffer(info, mbi_buf, mbi_bytes, mbi_bytes, 4,
+			  mhi.rel_tag->min_addr, mhi.rel_tag->max_addr, 1);
+
+	elf_rel_get_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
+	regs.eax = MULTIBOOT2_BOOTLOADER_MAGIC;
+	regs.ebx = addr;
+	regs.eip = ehdr.e_entry;
+	elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
+
+	return 0;
+}
diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index fb0e6f9..ec7b7ad 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -34,6 +34,8 @@
 #include <arch/options.h>
 
 struct file_type file_type[] = {
+	{ "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
+	  multiboot2_x86_usage },
 	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
 	  multiboot_x86_usage },
 	{ "elf-x86", elf_x86_probe, elf_x86_load, elf_x86_usage },
diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile
index 1cf10f9..275add5 100644
--- a/kexec/arch/x86_64/Makefile
+++ b/kexec/arch/x86_64/Makefile
@@ -4,6 +4,7 @@
 x86_64_KEXEC_SRCS =  kexec/arch/i386/kexec-elf-x86.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-bzImage.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-multiboot-x86.c
+x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-mb2-x86.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-beoboot-x86.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index ccdc980..3c593ac 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -34,6 +34,8 @@
 
 struct file_type file_type[] = {
 	{ "elf-x86_64", elf_x86_64_probe, elf_x86_64_load, elf_x86_64_usage },
+	{ "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
+	  multiboot2_x86_usage },
 	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
 	  multiboot_x86_usage },
 	{ "elf-x86", elf_x86_probe, elf_x86_load, elf_x86_usage },
diff --git a/kexec/arch/x86_64/kexec-x86_64.h b/kexec/arch/x86_64/kexec-x86_64.h
index 4cdeffb..21c3a73 100644
--- a/kexec/arch/x86_64/kexec-x86_64.h
+++ b/kexec/arch/x86_64/kexec-x86_64.h
@@ -33,4 +33,9 @@ int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info);
 void bzImage64_usage(void);
 
+int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
+			struct kexec_info *info);
+void multiboot2_x86_usage(void);
+int multiboot2_x86_probe(const char *buf, off_t buf_len);
+
 #endif /* KEXEC_X86_64_H */
diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 2fafaaa..2580725 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -311,6 +311,30 @@ with command-line arguments
 .I "arg1 arg2 ..."
 This parameter can be specified multiple times.
 .RE
+.PP
+.B multiboot2-x86
+.RS
+.TP
+.BI \-\-command\-line= string
+Set the kernel command line to
+.IR string .
+.TP
+.BI \-\-reuse-cmdline
+Use the command line from the running system. When a panic kernel is loaded, it
+strips the
+.I
+crashkernel
+parameter automatically. The
+.I BOOT_IMAGE
+parameter is also stripped.
+.TP
+.BI \-\-module= "mod arg1 arg2 ..."
+Load module
+.I mod
+with command-line arguments
+.I "arg1 arg2 ..."
+This parameter can be specified multiple times.
+.RE
 
 .SH ARCHITECTURE OPTIONS
 .TP
-- 
2.7.4




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
Ust-ID: DE 289 237 879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
