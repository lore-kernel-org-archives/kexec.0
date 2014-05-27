Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WpGbG-0001wY-IE
 for kexec@lists.infradead.org; Tue, 27 May 2014 12:35:26 +0000
Date: Tue, 27 May 2014 08:34:46 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH 00/11][V2] kexec: A new system call to allow in
 kernel loading
Message-ID: <20140527123446.GB10994@redhat.com>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <20140526082514.GA25732@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140526082514.GA25732@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On Mon, May 26, 2014 at 10:25:14AM +0200, Borislav Petkov wrote:
> Hi Vivek,
> 
> On Mon, Jan 27, 2014 at 01:57:40PM -0500, Vivek Goyal wrote:
> > Hi
> > 
> > This is V2 of new system call patches. Previous version was posted here.
> 
> just a quick ping here, are you working on a v3? Anything I can help with?

Hi Boris,

Yes, I am working on V3. I have been doing some more work to complete the
series. Specifically make the patches work with UEFI system and also wrote
code for verifying PKCS7 signature of bzImage. Signature verification code
I will post separately.

I am just battling a weared race condition where nested kdump seems to
fail on UEFI system sometimes. Some checksum issue. Hopefully I will be able
to resolve soon and repost patches for review.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
