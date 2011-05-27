Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QQ1g0-00067h-DB
	for kexec@lists.infradead.org; Fri, 27 May 2011 18:22:25 +0000
Date: Fri, 27 May 2011 14:22:10 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC Patch 6/6] Crash: Recognise slim coredumps and process new
	elf-note sections
Message-ID: <20110527182210.GH8053@redhat.com>
References: <20110526170722.GB23266@in.ibm.com>
	<20110526172618.GB18295@in.ibm.com>
	<m11uzk80vx.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m11uzk80vx.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wang Chao <wang.chao@cn.fujitsu.com>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, prasad@linux.vnet.ibm.com, crash-utility@redhat.com

On Fri, May 27, 2011 at 11:16:34AM -0700, Eric W. Biederman wrote:
> "K.Prasad" <prasad@linux.vnet.ibm.com> writes:
> 
> > Crash: Recognise slim coredumps and process new elf-note sections
> >
> > The Linux kernel will begin to support SlimDump for certain types of crashes
> > and the 'crash' tool needs to recognise them. For these types of coredumps, it
> > need not lookout for usual elf-structures and start gdb. Also process new
> > elf-note sections that contain additional information about the crash.
> 
> I suppose patching crash make sense.
> 
> Unfortunately crash doesn't work on  99% of the  kernels I run so, so I
> stopped caring a while ago.

Are these patched kernels? Otherwise Dave Anderson is pretty good about
keeping crash running across multiple kernels.

For me it works just great. I recently analyzed a crash dump with
2.6.39-rc7 kernel. Dave is generally takes patches for crash for latest
upstream kernel changes.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
