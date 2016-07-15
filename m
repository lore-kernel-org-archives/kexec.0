Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 15 Jul 2016 09:03:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160715130342.GB23514@redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <5352106.oQ0Ff9gWJA@wuerfel> <20160713094127.GC14522@leverpostej>
 <7352796.seiSnHrYPy@wuerfel>
 <20160715084925.GD1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160715084925.GD1041@n2100.armlinux.org.uk>
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, bhe@redhat.com, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Fri, Jul 15, 2016 at 09:49:25AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 13, 2016 at 03:13:42PM +0200, Arnd Bergmann wrote:
> > On Wednesday, July 13, 2016 10:41:28 AM CEST Mark Rutland wrote:
> > > The big question is whether this is a realistic case on a secure boot
> > > system.
> > 
> > What does x86 do here? I assume changes to the command line are also
> > limited.
> 
> They aren't.  You can specify /anything/ even with a fully-signed kernel
> and initrd, which was one of the things I pointed out in my previous
> set of responses.

Yes, kernel command line is not signed. For that matter even initird is
not signed. Just kernel is signed and its signatures are verified. Idea
is an unsigned code should not be able to execute in kernel space.

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
