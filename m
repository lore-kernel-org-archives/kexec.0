Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hLfPh-0002D7-IK
 for kexec@lists.infradead.org; Wed, 01 May 2019 02:56:07 +0000
Received: by mail-qk1-x741.google.com with SMTP id p19so9540625qkm.10
 for <kexec@lists.infradead.org>; Tue, 30 Apr 2019 19:56:04 -0700 (PDT)
Date: Tue, 30 Apr 2019 22:56:01 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Subject: Re: [SeaBIOS] Real mode kexec failure with non-IDE disk
Message-ID: <20190501025601.GA5342@morn.lan>
References: <e5872703412f9a56c10df52d9793ca2a6401d7f0.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e5872703412f9a56c10df52d9793ca2a6401d7f0.camel@infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: seabios@seabios.org, kexec <kexec@lists.infradead.org>

On Mon, Apr 29, 2019 at 12:05:33AM +0300, David Woodhouse wrote:
> When I kexec either Xen or Linux in real mode, from either Xen or
> Linux, it fails.
> 
> The last thing I see looks like SeaBIOS trying to use SMM for call32:
> 
> ----------------
> IN: 
> 0x00000000000f70ec:  mov    %eax,%esi
> 0x00000000000f70ef:  mov    $0xb5,%eax
> 0x00000000000f70f5:  mov    $0x1234,%ecx
> 0x00000000000f70fb:  mov    $0xef3dc,%ebx
> 0x00000000000f7101:  out    %al,$0xb2
> 0x00000000000f7103:  pause  
> 
> ----------------
> IN: 
> 0x00000000000ef3db:  hlt    
> 
> This happens when the real mode boot code calls INT 13h to read from
> the disk. It seems to happen with virtio and SATA disks.
> 
> This is with the Ubuntu-packaged 1.10.2-1ubuntu1 SeaBIOS. Switching to
> an IDE disk, or booting with 'edd=skipmbr', makes Xen work and Linux
> get a little further before it dies anyway.

Hi David,

That call trace certainly looks odd.  The SeaBIOS debugging info would
help - try compiling SeaBIOS with debug level 8 and grab the log (as
described at: https://www.seabios.org/Debugging#Diagnostic_information
).

-Kevin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
