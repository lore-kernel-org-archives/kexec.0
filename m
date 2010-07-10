Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OXTgQ-0007aa-L7
	for kexec@lists.infradead.org; Sat, 10 Jul 2010 06:37:08 +0000
Date: Sat, 10 Jul 2010 15:37:01 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec for powerpc mpc85xx processors
Message-ID: <20100710063701.GA12280@verge.net.au>
References: <AANLkTink0yPL5tiAZ88LsALQ0Xf0EeJjPOHCV-YO5ll5@mail.gmail.com>
	<1278656898.25847.2.camel@localhost>
	<20100709064324.GA24576@verge.net.au>
	<AANLkTilsFiyT0hLzHO2cvoZzyu7Bdizsdhr9v_sAGODd@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTilsFiyT0hLzHO2cvoZzyu7Bdizsdhr9v_sAGODd@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: krish <radhakrishna.p@gmail.com>
Cc: Matthew McClintock <msm@freescale.com>, kexec@lists.infradead.org

On Sat, Jul 10, 2010 at 10:14:25AM +0530, krish wrote:
> Hi,
> 
> I am using linux-2.6.34.1 version for both mpc83xx and mpc85xx processors.
> This version of kernel supports kexec for both 83xx and 85xx processors.
> I have been using ELDK toolchain for PowerPC processors.
> I am using u-boot as boot loader and uImage & dtb images as Linux images.
> 
> I have downloaded 2.0.2-rc1 package and tried to compile for mpc83xx.
> I have used following command to configure kexec-tools for ppc.
> ./configure --prefix=/home/krishna/work/kexec-tools-6dd624d/
> CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc LD=/opt/ELDK41/usr/bin/ppc_6xx-ld
> BUILD_CC=/usr/bin/gcc --target=ppc --host=i686
> CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc
> TARGET_CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc;
> 
> The compilation was broken for PPC.

Could you provide the compile errors that you are seeing?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
