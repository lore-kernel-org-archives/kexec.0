Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tfn9W-0005Ve-S9
 for kexec@lists.infradead.org; Tue, 04 Dec 2012 07:42:51 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so1389795bkc.36
 for <kexec@lists.infradead.org>; Mon, 03 Dec 2012 23:42:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50BDA016.2070404@zytor.com>
References: <1354140594-3686-1-git-send-email-yinghai@kernel.org>
 <20121204054709.GB15969@verge.net.au> <50BDA016.2070404@zytor.com>
Date: Mon, 3 Dec 2012 23:42:48 -0800
Message-ID: <CAE9FiQUxmfO1NdZCPooMzDRj6NBQYWJBZwn6Aiozq8J4NtAJwg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] kexec: put bzImage and ramdisk above 4G for x86
 64bit
From: Yinghai Lu <yinghai@kernel.org>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Dec 3, 2012 at 11:02 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 12/03/2012 09:47 PM, Simon Horman wrote:
>>
>> Hi Everyone,
>>
>> there was some healthy discussion around the previous versions
>> of this series, but so far none on this version. Have we reached
>> consensus?
>>
>
> No, we haven't converged on the boot protocol yet and just respinning the
> patch set doesn't change that.

please check if you are ok with bit 15 in xloadflags.

+Field name:     xloadflags
+Type:           modify (obligatory)
+Offset/size:    0x236/2
+Protocol:       2.12+
+
+  This field is a bitmask.
+
+  Bit 0 (read): CAN_BE_LOADED_ABOVE_4G
+        - If 1, kernel/boot_params/cmdline/ramdisk can be above 4g,
+
+  Bit 15 (write): USE_EXT_BOOT_PARAMS
+       - If 1, set by bootloader, and kernel could check new fields
+               in boot_params that are added from 2.12 safely.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
