Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Wed, 20 Jul 2016 13:12:20 +0200
Message-ID: <34243612.Gid3QHG1hd@wuerfel>
References: <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160720083530.GK1041@n2100.armlinux.org.uk>
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com, Petr Tesarik <ptesarik@suse.cz>, Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>, linux-arm-kernel@lists.infradead.org

On Wednesday, July 20, 2016 8:47:45 PM CEST Michael Ellerman wrote:
> At least for stdout-path, I can't really see how that would significantly help
> an attacker, but I'm all ears if anyone has ideas.

That's actually an easy one that came up before: If an attacker controls
a tty device (e.g. network console) that can be used to enter a debugger
(kdb, kgdb, xmon, ...), enabling that to be the console device
gives you a direct attack vector. The same thing will happen if you
have a piece of software that intentially gives extra rights to the
owner of the console device by treating it as "physical presence".

	Arnd


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
