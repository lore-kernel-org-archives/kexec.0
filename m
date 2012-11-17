Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZe0S-0002M4-RI
 for kexec@lists.infradead.org; Sat, 17 Nov 2012 08:44:05 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-9-git-send-email-yinghai@kernel.org>
 <87625420y5.fsf@xmission.com>
 <CAE9FiQWJaT9yfdV0rgV-5rM=BR4eX8sr+a99g8Ggf-+YkD8qgQ@mail.gmail.com>
Date: Sat, 17 Nov 2012 00:43:51 -0800
In-Reply-To: <CAE9FiQWJaT9yfdV0rgV-5rM=BR4eX8sr+a99g8Ggf-+YkD8qgQ@mail.gmail.com>
 (Yinghai Lu's message of "Sat, 17 Nov 2012 00:24:03 -0800")
Message-ID: <876254zkjc.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 8/8] x86: put 64bit bzImage high
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

Yinghai Lu <yinghai@kernel.org> writes:

> On Fri, Nov 16, 2012 at 10:33 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Yinghai Lu <yinghai@kernel.org> writes:
>>
>>> also need to make sure pass right 64bit start address to go there
>>> directly later.
>>
>> There are some silly things here but I think the clean way to handle
>> this is to create a kexec/arch/i386/kexec-bzImage64.c that handles
>> loading a bzImage with a 64bit entry point.
>>
>> That should keep the code simpler and easier to read.  Although it will
>> probably introduce a bit more code.
>
> please check attached one with kexec-bzImage64.c

Yes that looks better.

So far I have just skimmed the code but this in particular is not
needed.  We are going in via the 64bit entry point so there is no
point in ever allocating the real mode buffer in the low 640k.

+	if (info->kexec_flags & (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)) {
+		/* If using bzImage for capture kernel, then we will not be
+		 * executing real mode code. setup segment can be loaded
+		 * anywhere as we will be just reading command line.
+		 */
+		setup_base = add_buffer(info, real_mode, setup_size, setup_size,
+			16, 0x3000, -1, -1);
+	} else {
+		/* Careful setup_base must be greater than 8K */
+		setup_base = add_buffer(info, real_mode, setup_size, setup_size,
+			16, 0x3000, 640*1024, 1);
+	}

That should be just;
+	/* No real mode code will be executing. setup segment can be loaded
+	 * anywhere as we will be just reading the command line.
+	 */
+	setup_base = add_buffer(info, real_mode, setup_size, setup_size,
+		16, 0x3000, -1, -1);

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
