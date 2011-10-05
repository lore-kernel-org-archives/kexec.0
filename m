Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBTmV-00025V-47
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 15:53:15 +0000
Date: Wed, 5 Oct 2011 11:52:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005155217.GE30146@redhat.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<m162k64c7w.fsf@fess.ebiederm.org>
	<20111003120336.GK2223@in.ibm.com>
	<20111004063440.GB5723@liondog.tnic>
	<20111005070728.GA2235@in.ibm.com>
	<20111005073111.GA13478@liondog.tnic>
	<20111005094727.GB7485@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111005094727.GB7485@in.ibm.com>
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
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, anderson@redhat.com, crash-utility@redhat.com

On Wed, Oct 05, 2011 at 03:17:27PM +0530, K.Prasad wrote:

[..]
> Fine with me. I see that the various IA32_MCi_Status registers will hold
> information about the error and use that to classify MCEs.
> 
> I think the best way to go about is to retain NT_NOCOREDUMP for non-DRAM
> errors also, but use the note-name field in the elf-note and distinguish the
> various types of errors...say, by using names such as "PANIC_MCE_DRAM",
> "PANIC_MCE_CACHE", etc (similar to the error codes described in the Intel
> manual). The upstream tools like 'makedumpfile' and 'crash' will have to
> be taught to parse the elf-note name and act accordingly.

I am assuming that basic MCE error messages are available in kernel log. 
Why can't user space simply scan the logs for MCE error and just save
the log buffers in case of MCE. That way a user gets the MCE information
while not trying to save the whole dump. And no need of an extra ELF note.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
