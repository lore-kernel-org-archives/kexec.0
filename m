Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RBLkv-0004uy-UP
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 07:19:10 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id p957Il2n000851
	for <kexec@lists.infradead.org>; Wed, 5 Oct 2011 12:48:47 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p957IkLj2674910
	for <kexec@lists.infradead.org>; Wed, 5 Oct 2011 12:48:47 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p957Ikcf014670
	for <kexec@lists.infradead.org>; Wed, 5 Oct 2011 12:48:46 +0530
Date: Wed, 5 Oct 2011 12:48:44 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005071844.GB2235@in.ibm.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004140437.GA28306@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111004140437.GA28306@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Borislav Petkov <bp@alien8.de>, crash-utility@redhat.com

On Tue, Oct 04, 2011 at 10:04:37AM -0400, Vivek Goyal wrote:
> On Mon, Oct 03, 2011 at 01:02:03PM +0530, K.Prasad wrote:
> > There are certain types of crashes induced by faulty hardware in which
> > capturing crashing kernel's memory (through kdump) makes no sense (or sometimes
> > dangerous).
> > 
> > A case in point, is unrecoverable memory errors (resulting in fatal machine
> > check exceptions) in which reading from the faulty memory location from the
> > kexec'ed kernel will cause double fault and system reset (leaving no
> > information for the user).
> 
> Prasad,
> 
> I am just trying to remember what was wrong with Andi's approach of
> disable MCE while copying the dump?
>

Hi Vivek,
	The behaviour upon a read operation on an UC memory location is
undefined and so we want to avoid it (previously discussed here:
http://article.gmane.org/gmane.linux.kernel/1146799). When we disable
MCE and copy the dump, we will invariably read the faulty memory
location.

Thanks,
K.Prasad
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
